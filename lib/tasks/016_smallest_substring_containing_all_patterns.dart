void testSmallestSubstringContainingAllPatterns() {
  (int,int) result;

  result = findSmallestSubstringWindow(['b'], 'a');
  print('[-1, -1]: [${result.$1}, ${result.$2}]');

  result = findSmallestSubstringWindow(['a'], 'a');
  print('[0, 0]: [${result.$1}, ${result.$2}]');

  result = findSmallestSubstringWindow(['abc', 'zyx'], 'xyzabcabczyx');
  print('[6, 11]: [${result.$1}, ${result.$2}]');
}

class _Pattern {
  final String pattern;
  int i = 0;
  bool _isFound = false;

  _Pattern(this.pattern);

  bool get isFound => _isFound;

  void reset() {
    i = 0;
    _isFound = false;
  }

  void checkNextChar(String s) {
    if (_isFound) return;
    if (s == pattern[i]) {
      if (i == pattern.length - 1) {
        _isFound = true;
      } else {
        i++;
      }
    } else {
      reset();
      if (s == pattern[0]) checkNextChar(s);
    }
  }
}

(int, int) findSmallestSubstringWindow(List<String> patterns, String S) {
  int minLength = 1100000;
  (int, int) result = (-1, -1);
  List<_Pattern> patternList = <_Pattern>[for (String pattern in patterns) _Pattern(pattern)];

  for (int i = 0; i < S.length; i++) {
    for (final pattern in patternList) pattern.reset();
    for (int k = i + 1; k <= S.length; k++) {
      if (_checkAllPatterns(patternList, S[k - 1])) {
        if (k - i < minLength) {
          minLength = k - i;
          result = (i, k - 1);
          break;
        }
      }
    }
  }
  return result;
}

bool _checkAllPatterns(List<_Pattern> patternList, String c) {
  for (final pattern in patternList) {
    pattern.checkNextChar(c);
    if (!pattern.isFound) return false;
  }
  return true;
}

