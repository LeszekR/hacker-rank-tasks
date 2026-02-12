import 'dart:math';

void testCandies() {
  print('10: ${candies([4, 6, 4, 5, 6, 2])}');
  print('4: ${candies([1, 2, 2])}');
  print('19: ${candies([2, 4, 2, 6, 1, 7, 8, 9, 2, 1])}');
  print('11: ${candies([2, 4, 3, 2, 1])}');
  print('4: ${candies([1,2,2])}');
}

int candies(List<int> arr) {
  int n = arr.length;
  if (n == 0) return 0;
  if (n == 1) return 1;

  List<int> result = List<int>.filled(n, 0);
  int prev, curr, next;

  curr = arr[0];
  next = arr[1];
  if (curr <= next) result[0] = 1;

  prev = arr[n - 2];
  curr = arr[n - 1];
  if (curr <= prev) result[n - 1] = 1;

  // lowest points and ascending slopes
  for (int i = 1; i < n - 1; i++) {
    prev = arr[i - 1];
    curr = arr[i];
    next = arr[i + 1];

    // low point
    if (curr <= prev && curr <= next) result[i] = 1;

    // ascending slope
    if (curr > prev) result[i] = result[i - 1] + 1;
  }

  // descending slopes
  for (int i = n - 2; i > 0; i--) {
    if (result[i] == 1) continue;

    curr = arr[i];
    next = arr[i + 1];

    if (curr > next) result[i] = max(result[i + 1] + 1, result[i]);
  }

  return result.reduce((a, b) => a + b);
}
