import 'dart:math';

int largestRectangle(List<int> h) {
  List<int> nextS = computeNextLowerS(h);
  List<int> prevS = computePrevLowerS(h);
  int result = 0;
  int currResult;

  for (int i = 0; i < h.length; i++) {
    currResult = h[i] * (nextS[i] - prevS[i] - 1);
    result = max(result, currResult);
  }
  return result;
}

List<int> computeNextLowerS(List<int> h) {
  List<int> nextS = List<int>.filled(h.length, h.length);
  List<int> stack = <int>[];

  for (int i = 0; i < h.length; i++) {
    while (stack.isNotEmpty && h[i] < h[stack.last]) {
      nextS[stack.removeLast()] = i;
    }
    stack.add(i);
  }
  return nextS;
}

List<int> computePrevLowerS(List<int> h) {
  List<int> prevS = List<int>.filled(h.length, -1);
  List<int> stack = <int>[];

  for (int i = h.length - 1; i >= 0; i--) {
    while (stack.isNotEmpty && h[i] < h[stack.last]) {
      prevS[stack.removeLast()] = i;
    }
    stack.add(i);
  }
  return prevS;
}
