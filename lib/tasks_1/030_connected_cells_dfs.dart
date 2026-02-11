import 'dart:math';

void testConnectedCellsDfs() {
  var matrix = [
    [1, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 1, 1, 1],
    [1, 1, 0, 0],
  ];
  print(connectedCellsDfs(matrix));
}

int connectedCellsDfs(List<List<int>> matrix) {
  int result = 0;
  List<List<_Cell>> cellMatrix = _transformIntoCellsMatrix(matrix);
  int n = matrix.length;
  int m = matrix[0].length;

  for (int x = 0; x < n; x++) {
    for (int y = 0; y < m; y++) {
      if (cellMatrix[x][y].isFilled && !cellMatrix[x][y].isVisited) {
        result = max(result, _dfs(cellMatrix, n, m, x, y));
      }
    }
  }
  return result;
}

int _dfs(List<List<_Cell>> matrix, int n, int m, int x, int y) {
  int result = 0;
  List<_Cell> stack = <_Cell>[];
  _Cell cell;
  int nx, ny;

  result += _inspectCell(matrix, stack, x, y);

  while (stack.isNotEmpty) {
    cell = stack.removeLast();
    nx = cell.x;
    ny = cell.y;

    // top-right
    if (nx < n - 1 && ny < m - 1) result += _inspectCell(matrix, stack, nx + 1, ny + 1);

    // top
    if (ny < m - 1) result += _inspectCell(matrix, stack, nx, ny + 1);

    // top-left
    if (nx > 0 && ny < m - 1) result += _inspectCell(matrix, stack, nx - 1, ny + 1);

    // left
    if (nx > 0) result += _inspectCell(matrix, stack, nx - 1, ny);

    // bottom-left
    if (nx > 0 && ny > 0) result += _inspectCell(matrix, stack, nx - 1, ny - 1);

    // bottom
    if (ny > 0) result += _inspectCell(matrix, stack, nx, ny - 1);

    // bottom-right
    if (nx < n - 1 && ny > 0) result += _inspectCell(matrix, stack, nx + 1, ny - 1);

    // right
    if (nx < n - 1) result += _inspectCell(matrix, stack, nx + 1, ny);
  }
  return result;
}

int _inspectCell(List<List<_Cell>> matrix, List<_Cell> stack, int x, int y) {
  _Cell cell = matrix[x][y];

  if (cell.isVisited || !cell.isFilled) return 0;

  cell.isVisited = true;
  stack.add(cell);
  return 1;
}

List<List<_Cell>> _transformIntoCellsMatrix(List<List<int>> matrix) {
  int n = matrix.length;
  int m = matrix[0].length;
  var cellsMatrix = List<List<_Cell>>.generate(n, (x) => List<_Cell>.generate(m, (y) => _Cell(x, y, matrix[x][y])));
  return cellsMatrix;
}

class _Cell {
  final int x;
  final int y;
  final bool isFilled;
  bool isVisited = false;

  _Cell(this.x, this.y, int value) : isFilled = value == 1;
}
