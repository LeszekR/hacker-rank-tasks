
void testMinAbsDifference(){
  print(minAbsDifference([1,2,3,4,5]));
}

int? minAbsDifference(List<int> numbers) {
  if (numbers.length < 2) return null;

  numbers.sort();

  int result = 9000000000000000000;
  int nextDiff;
  int a = numbers[0];
  int b;

  for (int i = 1; i < numbers.length; i++) {
    b = numbers[i];
    nextDiff = b - a;
    if (nextDiff < result) result = nextDiff;
    a = b;
  }
  return result;
}
