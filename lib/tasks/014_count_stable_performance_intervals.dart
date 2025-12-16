import 'dart:collection';

void testCountValidSubarrays() {
  print('6: ${countValidSubarrays([1,2,3], 2)}');
}

int countValidSubarrays(List<int> a, int k) {
  Queue<int> maxQ = Queue<int>();
  Queue<int> minQ = Queue<int>();
  int result = 0;

  for (int i = 0; i < a.length; i++) {
    maxQ.clear();
    minQ.clear();
    for (int r = i; r < a.length; r++) {
      _addToMax(a, maxQ, r);
      _addToMin(a, minQ, r);
      if (a[maxQ.first] - a[minQ.first] <= k) {
        result++;
      }
    }
  }
  return result;
}

void _addToMax(List<int> a, Queue<int> maxQ, int r) {
  while (maxQ.isNotEmpty && a[maxQ.last] < a[r]) maxQ.removeLast();
  maxQ.addLast(r);
}

void _addToMin(List<int> a, Queue<int> minQ, int r) {
  while (minQ.isNotEmpty && a[minQ.last] > a[r]) minQ.removeLast();
  minQ.addLast(r);
}
