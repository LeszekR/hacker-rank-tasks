void testCanPlaceSecurityCameras() {
  canPlaceSecurityCameras(0, 4, 4);
}

// TODO incorrect - fix it
void canPlaceSecurityCameras(int N, int nRows, int nColumns) {
  final List<_State> stack = <_State>[];

  List<List<int>> grid = _makeGrid(nRows, nColumns);
  stack.add(_State(grid));

  void dfs(int row) {
    while (stack.isNotEmpty) {
      final lastState = stack.removeLast();

      if (lastState.isFull) {
        print(lastState.grid.toString());
      } else {
        for (int col = 0; col < nColumns; col++) {
          final nextState = _State.from(lastState);
          nextState.row = row;
          nextState.col = col;
          nextState.grid[row][col] = 1;
          stack.add(nextState);
        }
        print ('=============================================================');
        dfs(lastState.row + 1);
      }
    }
  }

  dfs(0);
}

List<List<int>> _makeGrid(int nRows, int nColumns) {
  var grid = <List<int>>[];
  for (int row = 0; row < nRows; row++) {
    grid.add(List<int>.filled(nColumns, 0));
  }
  return grid;
}

void _copyGrid(List<List<int>> source, List<List<int>> target){
  for (int row = 0; row < source.length; row++) {
    for (int col = 0; col < source[0].length; col++) {
      target[row][col] = source[row][col];
    }
  }
}

class _State {
  final List<List<int>> grid;
  int row = 0;
  int col = 0;

  bool get isFull => (row == grid.length - 1);

  _State(this.grid);

  factory _State.from(_State prev) {
    var grid = _makeGrid(prev.grid.length, prev.grid[0].length);
    _copyGrid(prev.grid, grid);
    return _State(grid);
  }
}
