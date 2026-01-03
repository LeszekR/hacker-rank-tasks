import 'dart:collection';
import 'dart:math';

void testConnectedCells() {
  var matrix = [
    [1, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1],
    [1, 1, 0, 0],
  ];
  print(connectedCells(matrix));
}

int connectedCells(List<List<int>> matrix) {
  int result = 0;
  int newResult;
  int n = matrix.length;
  int m = matrix[0].length;
  List<List<_Cell>> cellMatrix = _makeCellMatrix(matrix);
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < m; y++) {
      if (cellMatrix[x][y].isFilled && !cellMatrix[x][y].isVisited) {
        newResult = _bfs(cellMatrix, n, m, x, y);
        result = max(result, newResult);
      }
    }
  }
  return result;
}

int _bfs(List<List<_Cell>> matrix, int n, int m, int x, int y) {
  int result = 0;
  Queue<_Cell> queue = Queue<_Cell>();
  _Cell next = matrix[x][y];
  int nx, ny;

  queue.addFirst(next);
  next.isVisited = true;
  result++;

  while (queue.isNotEmpty) {
    next = queue.removeFirst();
    nx = next.x;
    ny = next.y;
    // top-left
    if (nx > 0 && ny > 0) result += _inspectCell(matrix, queue, nx - 1, ny - 1);

    // left
    if (nx > 0) result += _inspectCell(matrix, queue, nx - 1, ny);

    // bottom-left
    if (nx > 0 && ny < m - 1) result += _inspectCell(matrix, queue, nx - 1, ny + 1);

    // bottom
    if (ny < m - 1) result += _inspectCell(matrix, queue, nx, ny + 1);

    // bottom-right
    if (nx < n - 1 && ny < m - 1) result += _inspectCell(matrix, queue, nx + 1, ny + 1);

    // right
    if (nx < n - 1) result += _inspectCell(matrix, queue, nx + 1, ny);

    // top-right
    if (nx < n - 1 && ny > 0) result += _inspectCell(matrix, queue, nx + 1, ny - 1);

    // top
    if (ny > 0) result += _inspectCell(matrix, queue, nx, ny - 1);
  }
  return result;
}

int _inspectCell(List<List<_Cell>> matrix, Queue<_Cell> queue, int x, int y) {
  _Cell next = matrix[x][y];
  if (next.isVisited) return 0;

  next.isVisited = true;
  if (next.isFilled) queue.addLast(next);

  return next.isFilled ? 1 : 0;
}

List<List<_Cell>> _makeCellMatrix(List<List<int>> matrix) {
  int n = matrix.length;
  int m = matrix[0].length;
  List<List<_Cell>> cellMatrix = List<List<_Cell>>.filled(n, <_Cell>[]);
  for (int x = 0; x < n; x++) {
    cellMatrix[x] = List<_Cell>.filled(m, _Cell(0, 0, 0));
    for (int y = 0; y < m; y++) {
      cellMatrix[x][y] = _Cell(x, y, matrix[x][y]);
    }
  }
  return cellMatrix;
}

class _Cell {
  final int x;
  final int y;
  final bool isFilled;
  bool isVisited = false;

  _Cell(this.x, this.y, int value) : isFilled = value == 1;
}
