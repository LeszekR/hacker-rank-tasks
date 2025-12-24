void testFindFirstOccurrence() {
  print('-1: ${findFirstOccurrence([1, 2, 3, 4, 5], 6)}');
  print('-1: ${findFirstOccurrence([1, 2, 2, 2, 4, 4, 4, 4, 5], 3)}');
  print('2: ${findFirstOccurrence([1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 6, 9, 12], 4)}');
}

int findFirstOccurrence(List<int> numbers, int k) {
  int l = 0;
  int r = numbers.length - 1;
  int next;
  while (l <= r) {
    next = (l + r) ~/ 2;
    if (numbers[next] < k) {
      l = next + 1;
    } else if (numbers[next] > k) {
      r = next - 1;
    } else if (next == 0) {
      return next;
    } else if (numbers[next - 1] < k) {
      return next;
    } else {
      r = next - 1;
    }
  }
  return -1;
}
