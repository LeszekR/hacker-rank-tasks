void testCountSubarraysWithSumAndMaxAtMost() {
  print('2: ${countSubarraysWithSumAndMaxAtMost(5, [1, -1, 3, 4, 5], 3, 3)}');
  print('2: ${countSubarraysWithSumAndMaxAtMost(6, [4,1,-2,4,4,4], 3, 4)}');
}

int countSubarraysWithSumAndMaxAtMost(int numsCount, List<int> nums, int k, int M) {
  int iStart;
  int iEnd;
  int sum = 0;
  int next;
  bool hasMax = false;
  int result = 0;

  for (iStart = 0; iStart < numsCount; iStart++) {
    hasMax = false;
    sum = 0;

    // walk End until number greater than maximum
    for (iEnd = iStart; iEnd < numsCount; iEnd++) {
      next = nums[iEnd];

      // —----------------------------------
      // M exceeded - stop here
      if (next > M) break;

      // —----------------------------------
      // M not exceeded
      // add to the sum
      sum += nums[iEnd];
      // check is maximum present
      hasMax |= nums[iEnd] == M;
      // total and max satisfied - increment the result
      if (sum == k && hasMax) result++;
    }
  }
  return result;
}
