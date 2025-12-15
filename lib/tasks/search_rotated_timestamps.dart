int testSearchRotatedTimestamps() {
  List<int> nums = [34, 55, 100, 1, 2, 3, 8, 16, 25];
  int target = 8;
  return searchRotatedTimestamps(9, nums, target);
}

int searchRotatedTimestamps(int numsCount, List<int> nums, int target) {
  int iLeft = 0;
  int iRight = numsCount - 1;
  int iMid;
  int numLeft, numRight, num;

  do {
    // if target - return the index
    numLeft = nums[iLeft];
    if (numLeft == target) return iLeft;

    numRight = nums[iRight];
    if (numRight == target) return iRight;

    iMid = iLeft + ((iRight - iLeft) / 2).toInt();
    num = nums[iMid];
    if (num == target) return iMid;

    // if left half is sorted
    if (numLeft < num) {
      // if target in the left part - search in the left part
      if (numLeft < target && num > target) {
        iRight = iMid - 1;
      }
      // else search the right part
      else {
        iLeft = iMid + 1;
      }

      // if left half is not sorted - then the right one is
    } else {
      // if target in the right part - search in the right part
      if (num < target && numRight > target) {
        iLeft = iMid + 1;
      }
      // else search the left part
      else {
        iRight = iMid - 1;
      }
    }
    // do until indexLeft > indexRight
  } while (iLeft < iRight);

  if (num == target) {
    return iMid;
  } else {
    return -1;
  }
}
