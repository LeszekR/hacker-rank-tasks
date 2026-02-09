void testFlowerPurchase() {
  print('11: ${flowerPurchase(3, [1, 2, 3, 4])}');
  print('15: ${flowerPurchase(2, [2, 5, 6])}');
  print('29: ${flowerPurchase(3, [1, 3, 5, 7, 9])}');
  print('25: ${flowerPurchase(11, [1, 3, 5, 7, 9])}');
}

int flowerPurchase(int k, List<int> flowers) {
  flowers.sort((a, b) => b.compareTo(a));

  int result = 0;
  int round = 0;
  int friend;
  int i = 0;

  while (i < flowers.length) {
    round++;
    friend = 0;
    while (i < flowers.length && friend < k) {
      result += flowers[i] * round;
      friend++;
      i++;
    }
  }
  return result;
}
