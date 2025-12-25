void testLexographicalLetterCombinationOfPhoneDigits() {
  print(lexographicalLetterCombinationOfPhoneDigits('21309'));
}

List<String> lexographicalLetterCombinationOfPhoneDigits(String digits) {
  Map<String, String> lettersMap = {
    '0': '0',
    '1': '1',
    '2': 'abc',
    '3': 'def',
    '4': 'ghi',
    '5': 'jkl',
    '6': 'mno',
    '7': 'pqrs',
    '8': 'tuv',
    '9': 'wxyz',
  };

  List<String> result = <String>[];
  List<String> buffer = List<String>.filled(digits.length, '');

  void dfs(int i) {
    if (i == digits.length) {
      result.add(buffer.join());
      return;
    }

    final String letters = lettersMap[digits[i]]!;

    for (int l = 0; l < letters.length; l++) {
      buffer[i] = letters[l];
      dfs(i + 1);
    }
  }

  dfs(0);

  return result;
}
