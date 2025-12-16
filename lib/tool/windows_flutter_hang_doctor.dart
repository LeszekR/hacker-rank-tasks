// Save as: tool/windows_flutter_hang_doctor.dart
//
// Run with:
//   dart run tool/windows_flutter_hang_doctor.dart
//
// Goal: collect useful diagnostics when `flutter run -d windows` hangs at
// "Syncing files to device Windows...".
//
// Notes (common fixes):
// 1) Run `flutter run -v -d windows` to see what it is waiting on.
// 2) Try `flutter clean` + delete `.dart_tool/` + delete `build/` + `flutter pub get`.
// 3) Temporarily disable antivirus / Controlled folder access (Windows Security) or add exclusions for:
//    - your project folder
//    - %LOCALAPPDATA%\Pub\Cache
//    - flutter SDK folder
// 4) Ensure Windows Firewall is not blocking Dart/Flutter (allow on private networks).
// 5) If you use VPN, try disconnecting it.
// 6) Try: `flutter run -d windows --disable-service-auth-codes` (rare, but can help debugging connectivity issues).

import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final log = StringBuffer();

  void section(String title) {
    log.writeln('\n===== $title =====');
  }

  Future<void> cmd(String title, String executable, List<String> args) async {
    section(title);
    log.writeln('> $executable ${args.join(' ')}');
    try {
      final result = await Process.run(
        executable,
        args,
        runInShell: true,
        stdoutEncoding: utf8,
        stderrEncoding: utf8,
      );
      log.writeln(result.stdout);
      if ((result.stderr as String).trim().isNotEmpty) {
        log.writeln('--- STDERR ---');
        log.writeln(result.stderr);
      }
      log.writeln('ExitCode: ${result.exitCode}');
    } catch (e, st) {
      log.writeln('ERROR: $e');
      log.writeln(st);
    }
  }

  // Basic environment checks
  await cmd('where flutter', 'where', ['flutter']);
  await cmd('where dart', 'where', ['dart']);
  await cmd('flutter --version', 'flutter', ['--version']);
  await cmd('flutter doctor -v', 'flutter', ['doctor', '-v']);
  await cmd('flutter devices', 'flutter', ['devices']);
  await cmd('flutter config', 'flutter', ['config']);

  // Pub cache health
  await cmd('flutter pub cache repair', 'flutter', ['pub', 'cache', 'repair']);

  // Show dependency situation
  await cmd('flutter pub outdated', 'flutter', ['pub', 'outdated']);

  // Try a verbose run (this is the most important signal)
  // If it hangs, stop it after ~30s and paste the last 200 lines of output.
  await cmd(
    'flutter run -v -d windows',
    'flutter',
    ['run', '-v', '-d', 'windows'],
  );

  // Write report
  final outPath = File('windows_flutter_hang_report.txt').absolute.path;
  await File(outPath).writeAsString(log.toString());
  stdout.writeln('Wrote report to: $outPath');

  // Quick actionable checklist printed at the end
  stdout.writeln('''
Next steps:
1) Open windows_flutter_hang_report.txt and search for "Syncing files" and lines right after it.
2) If it always hangs at Syncing:
   - run: flutter clean
   - delete folders: build, .dart_tool
   - run: flutter pub get
   - run: flutter run -v -d windows
3) Temporarily disable antivirus / Controlled folder access, or add exclusions (project, Pub Cache, Flutter SDK).
4) Ensure Windows Firewall allows Dart/Flutter (private network).
5) Try without VPN.
''');
}
