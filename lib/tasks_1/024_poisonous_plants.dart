import 'dart:math';

void testPoisonousPlants() {
  print('2: ${poisonousPlants([6, 5, 8, 4, 7, 10, 6])}');
  print('1: ${poisonousPlants([6, 5, 8, 4, 7, 10, 11])}');
}

int poisonousPlants(List<int> p) {
  int result = 0;
  List<_Plant> stack = <_Plant>[];
  int days, x;

  for (int i = 0; i < p.length; i++) {
    days = 0;
    x = p[i];

    while (stack.isNotEmpty && stack.last.x >= x) {
      days = max(days, stack.last.days);
      stack.removeLast();
    }
    if (stack.isEmpty) {
      days = 0;
    } else {
      days += 1;
      result = max(result, days);
    }
    stack.add(_Plant(x, days));
  }
  return result;
}

class _Plant {
  final int x;
  final int days;

  const _Plant(this.x, this.days);
}
