import 'dart:collection';

String bfsShortestReach(int n, List<List<int>> edges, int s) {
  final Map<int, _Vortex> vortexMap = _makeVortexMap(n, edges);

  bfs(vortexMap, s);

  final List<_Vortex> vortexList = vortexMap.values.toList();
  vortexList.sort((a, b) => a.id.compareTo(b.id)); // perhaps redundant? - data is sorted already after _makeVortexMap?
  final String result = _extractDistances(vortexList);

  return result;
}

String _extractDistances(List<_Vortex> vortexList) {
  final buffer = StringBuffer();
  for (var v in vortexList) {
    buffer.write('${v.distance} ');
  }
  return buffer.toString();
}

void bfs(Map<int, _Vortex> vortexMap, int s) {
  final queue = Queue<_Vortex>();
  _Vortex next, neighbour;

  next = vortexMap[s]!;
  next.isVisited = true;
  next.distance = 0;
  queue.add(next);

  while (queue.isNotEmpty) {
    next = queue.removeFirst();

    for (final int v in next.neighbourIds) {
      neighbour = vortexMap[v]!;
      if (neighbour.isVisited) continue;

      neighbour.isVisited = true;
      neighbour.distance = next.distance + 6;

      queue.addLast(neighbour);
    }
  }
}

Map<int, _Vortex> _makeVortexMap(int n, List<List<int>> edges) {
  final Map<int, _Vortex> vortexMap = {for (int i = 0; i < n; i++) i + 1: _Vortex(i + 1)};
  for (int i = 0; i < edges.length; i++) {
    vortexMap[edges[i][0] + 1]!.neighbourIds.add(edges[i][1]);
  }
  return vortexMap;
}

class _Vortex {
  final int id;
  int distance = -1;
  bool isVisited = false;
  Set<int> neighbourIds = <int>{};

  _Vortex(this.id);
}
