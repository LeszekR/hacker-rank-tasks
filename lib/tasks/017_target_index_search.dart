void testBinarySearch() {
  print('3: ${binarySearch([1, 2, 3, 4, 5], 4)}');
  print('-1: ${binarySearch([1, 2, 4, 5], 3)}');
}

int binarySearch(List<int> numbers, int k) {
  int l = 0;
  int r = numbers.length - 1;
  int next;
  while(l <= r) {
    next = (l + r)  ~/ 2;
    if (numbers[next] < k) {
      l = next + 1;
    } else if (numbers[next] > k) {
      r = next - 1;
    } else if (numbers[next] == k) {
      return next;
    }
  }
  return -1;
}
