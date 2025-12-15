void testMatrixRotation() {
  List<List<int>> matrix =
  [
    [1, 2, 3, 4,],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16]
  ];
  matrix =
  [
    [91, 92, 93, 94, 95],
    [96, 97, 98, 99, 81],
    [11, 12, 13, 14, 15],
    [16, 17, 18, 19, 20],
    [21, 22, 23, 24, 25],
    [26, 27, 28, 29, 30]
  ];
  matrixRotation(matrix, 5);
}

void _printMatrix(List<List<int>> matrix, int h, int v){
  String line;
  for (int vi = 0; vi < v; vi++) {
    line = '';
    for (int hi = 0; hi < h; hi++) {
      line = '$line${matrix[vi][hi]} ';
    }
    print(line);
  }
}
void matrixRotation(List<List<int>> matrix, int r) {
  int v = matrix.length;        // vertical axis
  int h = matrix[0].length;     // horizontal axis
  // TODO assumption to correct later: v is even (either v or h is)

  _printMatrix(matrix, h, v);
  List<List<int>> matrixLayers = _makeMatrixLayers(h, v);
  _copySquareToFromLayers(matrix, matrixLayers, h, v, ToggleDirection.toLayers);
  print ('${matrixLayers.toString()}');
  List<List<int>> rotatedLayers = _rotateMatrix(matrixLayers, h, v, r);
  print ('${rotatedLayers.toString()}');
  _copySquareToFromLayers(matrix, rotatedLayers, h, v, ToggleDirection.fromLayers);
  _printMatrix(matrix, h, v);
}

List<List<int>> _makeMatrixLayers(int h, int v) {
  int nLayers = (v / 2).toInt();
  int layerCircumference;

  List<List<int>> matrixLayers = List<List<int>>.empty(growable: true);
  List<int> layer;
  for (int l = 0; l < nLayers; l++) {
    layerCircumference = 2 * ((h - 2 * l - 1) + (v - 2 * l - 1));
    layer = List<int>.filled(layerCircumference, 0);
    matrixLayers.add(layer);
  }
  return matrixLayers;
}

enum ToggleDirection { toLayers, fromLayers }

void _copySquareToFromLayers(
    List<List<int>> matrix,
    List<List<int>> matrixLayers,
    int h,
    int v,
    ToggleDirection direction) {

  // l - layer, from 0 to < height / 2
  List<int> layer;
  int x;

  for (int l = 0; l < v / 2; l++) {
    layer = matrixLayers[l];
    x = 0;

    // top horizontal side
    for (int thi = l; thi < h - l - 1; thi++) {
      if (direction == ToggleDirection.toLayers) {
        layer[x] = matrix[l][thi];
      } else {
        matrix[l][thi] = layer[x];
      }
      x++;
    }

    // right vertical side
    for (int rvi = l; rvi < v - l - 1; rvi++) {
      if (direction == ToggleDirection.toLayers) {
        layer[x] = matrix[rvi][h - l - 1];
      } else {
        matrix[rvi][h - l - 1] = layer[x];
      }
      x++;
    }

    // bottom horizontal side
    for (int thi = h - l - 1; thi > l; thi--) {
      if (direction == ToggleDirection.toLayers) {
        layer[x] = matrix[v - l - 1][thi];
      } else {
        matrix[v - l - 1][thi] = layer[x];
      }
      x++;
    }

    // left vertical side
    for (int rvi = v - l - 1; rvi > l; rvi--) {
      if (direction == ToggleDirection.toLayers) {
        layer[x] = matrix[rvi][l];
      } else {
        matrix[rvi][l] = layer[x];
      }
      x++;
    }
  }
}

List<List<int>> _rotateMatrix(List<List<int>> matrixLayers, int h, int v, int r) {
  List<List<int>> allRotatedLayers = _makeMatrixLayers(h, v);
  List<int> layer, rotatedLayer;

  for (int l = 0; l < v / 2; l++) {
    layer = matrixLayers[l];
    rotatedLayer = allRotatedLayers[l];

    int layerCircumference = layer.length;
    for (int i = 0; i < layerCircumference; i++) {
      rotatedLayer[i] = layer[(i + r) % layerCircumference];
    }
  }
  return allRotatedLayers;
}
