void testMaximumSum() {
  List<int> a;
  a = [1, 2, 3];
  print('1: ${maximumSum(a, 2)}');
}

int maximumSum(List<int> a, int m) {
  int result = 0;
  int sum;
  int modulo;

  for (int i = 0; i < a.length; i++) {
    sum = 0;

    for (int k = i; k < a.length; k++) {
      sum += a[k];
      modulo = sum % m;
      if (modulo > result) result = modulo;
    }
  }
  return result;
}
