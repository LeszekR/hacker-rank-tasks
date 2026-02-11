import 'dart:math';

void testTwoPluses() {
  print(
    twoPluses([
      ['B', '+', 'B', 'B', '+'],
      ['+', '+', '+', 'B', '+'],
      ['B', '+', 'B', '+', '+'],
      ['B', 'B', '+', '+', '+'],
      ['B', 'B', 'B', '+', '+'],
    ]),
  );
}

int twoPluses(List<List<String>> grid) {
  int width = grid.length;
  int height = grid[0].length;

  if (width < 3 || height < 3) return 1;

  List<_Plus> pluses = <_Plus>[];

  _Plus? plus;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      plus = _getPlus(grid, x, y);
      if (plus != null) pluses.add(plus);
    }
  }

  int result = 0;
  int product = 0;
  _Plus a, b;

  for (int start = 0; start < pluses.length - 1; start++) {
    for (int end = start + 1; end < pluses.length; end++) {
      a = pluses[start];
      b = pluses[end];
      if (!_isOverlap(a, b)) {
        product = (a.armLength * 4 + 1) * (b.armLength * 4 + 1);
        if (product > result) result = product;
      }
    }
  }
  return result;
}

_Plus? _getPlus(List<List<String>> grid, int x, int y) {
  if (grid[x][y] == 'B') return null;

  int smallerSide = min(grid.length, grid[0].length);

  int i = 1;
  // TODO fix going out of bounds
  for (i; i <= smallerSide ~/ 2; i++) {
    // top
    if (x - i < 0 || grid[x - i][y] == 'B') break;

    // left
    if (y - i < 0 || grid[x][y - i] == 'B') break;

    // bottom
    if (x + i < 0 || grid[x + i][y] == 'B') break;

    // right
    if (y + i < 0 || grid[x][y + i] == 'B') break;
  }
  return _Plus(x, y, i - 1);
}

bool _isOverlap(_Plus a, _Plus b) {
  int xDiff = a.x - b.x;
  xDiff = xDiff.abs();

  int yDiff = a.y - b.y;
  yDiff = yDiff.abs();

  int boundary = min(a.armLength, b.armLength);
  return xDiff <= boundary && yDiff <= boundary;
}

class _Plus {
  final int x;
  final int y;
  final int armLength;

  const _Plus(this.x, this.y, this.armLength);
}
