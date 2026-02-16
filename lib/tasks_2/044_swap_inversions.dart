void testSwapInversions() {
  print('3: ${swapInversions([2, 3, 4, 1, 5])}')  ;
  print('14: ${swapInversions([2, 8, 4, 1, 5, 2, 1, 7])}')  ;
}

int swapInversions(List<int> arr) {
  int n = arr.length;
  Set<int> numbers = {};
  for (int i = 0; i < n; i++){
    numbers.add(arr[i]);
  }

  int result = 0;
  int bigger;
  int element;

  for (int next in numbers){
    bigger = 0;
    for (int i = 0; i < n; i++){
      element = arr[i];
      if(element == next) {
        result += bigger;
      } else if (element > next) {
        bigger++;
      }
    }
  }
  return result;
}
