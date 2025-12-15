int testPeakIndex () {
  List<int> counts = [2,8,15,66,68,100,1];
  return findPeakIndex(7, counts);
}

int findPeakIndex(int countsCount, List<int> counts) {
  int iLeft = 0;
  int iRight = countsCount - 1;
  int iMid;
  int num, numLeft, numRight;

  if (countsCount == 0) return - 1;
  if (countsCount == 1) return 0;
  if (countsCount == 2) return counts[0] < counts [1] ? 1 : 0;

  do {
    // get mid number
    iMid = ((iLeft + iRight) / 2).toInt();
    num = counts[iMid];

    // bingo, mid is max
    if (num > counts[iMid - 1] && num < counts[iMid + 1]) {
      return iMid;
    }

    // if mid is on asc side
    else if (num > counts[iMid - 1]) {
      iLeft = iMid;
    }

    // else mid is on desc side
    else {
      iRight = iMid - 1;
    }

  } while (iLeft > iRight);

  return iMid;
}
