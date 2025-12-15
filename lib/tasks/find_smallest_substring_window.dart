void testFindSmallestSubstringWindow() {
  print('[0, 3]: ${findSmallestSubstringWindow(3, ['ab', 'bc', 'cd'], 'abcde').toString()}');
  print('[5, 9]: ${findSmallestSubstringWindow(3, ['ab', 'bc', 'cda'], 'abcdeabcda').toString()}');
}


List<int> findSmallestSubstringWindow(int patternsCount, List<String> patterns, String S) {
  int iStart, iEnd;
  Result nextResult;
  Result finalResult = Result();

  for (iStart = 0; iStart < S.length; iStart++) {
    for(iEnd = iStart; iEnd < S.length; iEnd++) {
      nextResult = _hasAllPatterns(S, iStart, iEnd, patterns);
      if (nextResult.length < finalResult.length) {
        finalResult = nextResult;
        // break loop incrementing end index since next end index will produce a longer substring as result
        break;
      }
    }
  }
  return [finalResult.indexStart, finalResult.indexEnd];
}


Result _hasAllPatterns(String S, int iStart, int iEnd, List<String> patterns) {
  for (int i = 0; i < patterns.length; i++) {
    if (!_hasPattern(S, iStart, iEnd, patterns[i])) return Result();
  }
  return Result(iEnd - iStart + 1, iStart, iEnd);
}


bool _hasPattern(String S, int iStart, int iEnd, String pattern) {
  for (int i = iStart; i <= iEnd - pattern.length + 1; i++) {
    if (_isPattern(S.substring(i, i + pattern.length), pattern)) return true;
  }
  return false;
}

bool _isPattern(String sb, String pattern) {
  for (int i = 0; i < pattern.length; i++) {
    if (sb[i] != pattern[i]) return false;
  }
  return true;
}


class Result {
  final int length;
  final indexStart;
  final indexEnd;
  Result([this.length = 10000000, this.indexStart = -1, this.indexEnd = -1]);
}

