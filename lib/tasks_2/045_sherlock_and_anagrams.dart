void testSherlockAndAnagrams() {
  print('3: ${sherlockAndAnagrams('abba')}');
}

int sherlockAndAnagrams(String a) {
  Map<String, int> freqs = {};
  for (int i = 0; i < 26; i++) {
    freqs[String.fromCharCode(65 + i)] = 0;
    freqs[String.fromCharCode(97 + i)] = 0;
  }
  ;

  Map<String, int> signatures = {};

  StringBuffer sb = StringBuffer();
  String makeSignature() {
    sb.clear();
    for (final int freq in freqs.values) {
      sb.write('$freq#');
    }
    return sb.toString();
  }

  void clearFreqs() {
    for (final String key in freqs.keys) {
      freqs[key] = 0;
    }
  }

  String sign, c;
  for (int i = 0; i < a.length; i++) {
    clearFreqs();
    for (int k = i; k < a.length; k++) {
      c = a[k];
      freqs[c] = (freqs[c] ?? 0) + 1;
      sign = makeSignature();
      signatures[sign] = (signatures[sign] ?? 0) + 1;
    }
  }

  Map<int, int> signFreqs = {};
  for (final int x in signatures.values) {
    if (x > 1) {
      signFreqs[x] = (signFreqs[x] ?? 0) + 1;
    }
  }

  int result = 0;
  int n;
  for (final int x in signFreqs.keys) {
    n = signFreqs[x]!;
    result += (n * (x / 2 * (x - 1))).toInt();
  }
  return result;
}
