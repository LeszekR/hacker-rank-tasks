void testIceCreamParlor() {
  print('[1, 4]: ${iceCreamParlor([1, 4, 5, 3, 2], 4)}');
  print('[2, 4]: ${iceCreamParlor([3, 1, 4, 5, 6], 6)}');
}

List<int> iceCreamParlor(List<int> prices, int budget) {
  Map<int, int> priceMap = {};

  for (int i = prices.length - 1; i >= 0; i--) {
    priceMap[prices[i]] = i + 1;
  }

  int diff;
  for (int price in priceMap.keys) {
    diff = budget - price;
    if (diff == price) continue;
    if (priceMap.containsKey(diff)) {
      return [priceMap[diff]!, priceMap[price]!];
    }
  }
  return [];
}
