int longestSubarrayOfPairs(List<int> S, int k) {
  int n = S.length;
  if (n < 2) return 0;

  int result = 0;
  int lengthOrIndex;
  int i = 0;
  int j = 1;
  while (i < n - 1 && j < n) {
    lengthOrIndex = _examinNewWindow(S, k, i, j);
    if (lengthOrIndex > 0) {
      if (lengthOrIndex > result) result = lengthOrIndex;
      j++;
    } else if (lengthOrIndex < 0) {
      i = lengthOrIndex * -1 + 1;
    } else {
      i++;
    }
    if (i == j) j++;
  }
  return result;
}

int _examinNewWindow(List<int> S, int k, int i, int j) {
  for (int a = i; a < j; a++) {
    if ((S[a] + S[j]) % k == 0) return a * -1;
  }
  return j - i + 1;
}
