void testCustomFibonacci() {
  print('5: ${customFibonacci(3)}');
  print('8: ${customFibonacci(4)}');
}

int customFibonacci(int n) {
  if (n == 0) return 1;
  if (n == 1) return 2;
  return customFibonacci(n-1) + customFibonacci(n - 2);
}
