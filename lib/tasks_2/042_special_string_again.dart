void testSpecialStrings() {
  print('7: ${specialStrings('asasd')}');
  print('12: ${specialStrings('mnonopoo')}');
  print('10: ${specialStrings('aaaa')}');
  print('18: ${specialStrings('aabaaabaa')}');
  print('16: ${specialStrings('aaabaaa')}');
}

int specialStrings(String s) {
  int n = s.length;

  int result = n;

  int countPlainSubstrings(String prev, int i) {
    int k = 1;
    int x = 1;
    while (i + k + 1 < n) {
      if (s[i + k + 1] == prev) {
        k++;
        x += k;
      } else {
        break;
      }
    }
    result += x;
    return i + k;
  }

  int countDividedSubstrings(String prev, int i) {
    int x = 1;
    while (i - x - 1 >= 0 && i + x + 1 < n) {
      if (s[i - x - 1] == prev && s[i + x + 1] == prev) {
        x++;
      } else {
        break;
      }
    }
    result += x;
    return i + x;
  }

  String prev, mid, next;

  for (int i = 1; i < n; i++) {
    prev = s[i - 1];
    next = s[i];
    if (prev == next) i = countPlainSubstrings(prev, i - 1);
  }

  for (int i = 2; i < n; i++) {
    prev = s[i - 2];
    mid = s[i - 1];
    next = s[i];
    if (prev == next && mid != prev) i = countDividedSubstrings(prev, i - 1);
  }

  return result;
}
