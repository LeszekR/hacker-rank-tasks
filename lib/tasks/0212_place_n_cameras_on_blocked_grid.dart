void testCanPlaceSecurityCameras2() {
  canPlaceSecurityCameras2(6);
}

bool canPlaceSecurityCameras2(int N) {
  var stack = <_State>[];
  stack.add(_State(N));

  while (stack.isNotEmpty) {
    final _State lastState = stack.removeLast();

    if (_isStateFull(lastState)) {
      print(lastState.grid.toString());
      // return true;
    } else {
      final row = lastState.row + 1;
      for (int col = 0; col < N; col++) {
        final newState = _State(N);
        _copyState(lastState, newState);
        bool isOk = _fillField(newState, row, col);
        if (isOk) stack.add(newState);
      }
      print('=============================================================');
    }
  }
  return false;
}

class _State {
  final Set<int> filledColumns = <int>{};
  late final List<List<int>> grid;
  int row = -1;

  _State(int N) {
    grid = [for (int i = 0; i < N; i++) List<int>.filled(N, 0)];
  }
}

bool _isDiagonalConflict(List<List<int>> grid, int row, int col) {
  int N = grid.length;

  if (row == col) {
    for (int i = 0; i < N; i++) {
      if (grid[i][i] == 1) {
        return true;
      }
    }
  } else if (col == (N - row - 1)) {
    for (int i = 0; i < N; i++) {
      if (grid[i][N - i - 1] == 1) {
        return true;
      }
    }
  }
  return false;
}

// TODO add support for blind fields
bool _fillField(_State state, int row, int col) {
  if (state.filledColumns.contains(col)) return false;
  if (_isDiagonalConflict(state.grid, row, col)) return false;
  state.grid[row][col] = 1;
  state.filledColumns.add(col);
  state.row = row;
  return true;
}

bool _isStateFull(_State state) {
  return state.row == state.grid.length - 1;
}

void _copyState(_State src, _State dst) {
  for (int r = 0; r < src.grid.length; r++) {
    for (int c = 0; c < src.grid[0].length; c++) {
      dst.grid[r][c] = src.grid[r][c];
    }
  }
  for (final col in src.filledColumns) {
    dst.filledColumns.add(col);
  }
}
