import 'dart:math';

void testMaxArraySum() {
  print('[7, 6]: ${maxArraySum([3, 7, 4, 6, 5])}');
  print('[7, 4, 5]: ${maxArraySum([3, 7, -2, 4, 6, 5])}');
  print('[7, 6, 4, 10, 7]: ${maxArraySum([7, 3, 5, 6, -2, 4, 0, 6, 10, 5, 7])}');
}

List<int> maxArraySum(List<int> arr) {
  int n = arr.length;

  if (n == 0) return [];
  if (n == 1) return arr;
  if (n == 2) return [max(arr[0], arr[1])];

  List<List<Sum?>> tab = List<List<Sum?>>.filled(n + 3, List<Sum?>.filled(n + 3, null));

  Sum emptySum = Sum();
  tab[0][0] = emptySum;
  tab[1][0] = emptySum;
  tab[1][1] = emptySum;
  tab[2][0] = emptySum;
  tab[2][1] = emptySum;
  tab[2][2] = emptySum;

  int j;
  int x;
  int newTotal;
  Sum? newSum, sum1, sum2, sum3;

  for (int i = 0; i < n; i++) {
    j = i + 3;
    x = arr[i];

    sum3 = tab[i][j - 3];
    sum2 = tab[i][j - 2];
    sum1 = tab[i][j - 1];

    if (x <= 0) {
      newSum = sum1;
    } else {
      newSum = Sum(sum1!.myNumber, sum1.prev, sum1.total);

      newTotal = x + sum2!.total;
      if (newTotal > newSum.total) {
        newSum.myNumber = x;
        newSum.prev = sum2;
        newSum.total = newTotal;
      }

      newTotal = x + sum3!.total;
      if (newTotal > newSum.total) {
        newSum.myNumber = x;
        newSum.prev = sum3;
        newSum.total = newTotal;
      }

    }
    for (int k = i + 1; k <= i + 3; k++) {
      tab[k][j] = newSum;
    }
  }

  List<int> result = [];
  Sum? prevSum = tab[n + 2][n + 2];
  while (prevSum != null) {
    if (prevSum.myNumber != null) result.add(prevSum.myNumber!);
    prevSum = prevSum.prev;
  }
  return result.reversed.toList();
}

class Sum {
  int? myNumber = null;
  Sum? prev = null;
  int total;

  Sum([this.myNumber, this.prev, this.total = 0]);
}
