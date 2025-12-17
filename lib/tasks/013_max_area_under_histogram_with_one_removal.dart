import 'dart:math';

void testComputeMaxRectangleAreaWithOneRemoval() {
  print('20: ${computeMaxRectangleAreaWithOneRemoval([5, 5, 1, 5, 5])}');
  print('42: ${computeMaxRectangleAreaWithOneRemoval([5, 21, 1, 30, 5])}');
  print('15: ${computeMaxRectangleAreaWithOneRemoval([1, 3, 5, 6, 8])}');
}

int computeMaxRectangleAreaWithOneRemoval(List<int> heights) {
  int result = 0;
  int nextResult;
  int height;
  int nextHeight;
  bool isRemoved;

  for (int i = 0; i < heights.length; i++) {
    height = heights[i];
    nextResult = 0;
    isRemoved = false;

    for (int k = i; k < heights.length; k++) {
      nextHeight = heights[k];

      if (nextHeight >= height) {
        nextResult += height;
      } else {
        // if we have not removed yet - we skip (remove) this one
        if (!isRemoved) {
          isRemoved = true;
        }
        // we’ve already removed one - we return to check the next bar
        else {
          break;
        }
      }
    }
    result = max(result, nextResult);
  }

  return result;
}
