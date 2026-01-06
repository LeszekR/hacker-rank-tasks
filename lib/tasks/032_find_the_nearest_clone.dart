import 'dart:collection';

int findShortest(int nNodes, List<int> graphFrom, List<int> graphTo, List<int> ids, int val) {
  if(nNodes < 2) return -1;

  int n = nNodes;
  List<int> src = List<int>.filled(n + 1, -1);
  List<int> dist = List<int>.filled(n + 1, -1);
  List<Set<int>> edges = List<Set<int>>.generate(n + 1, (_) => <int>{});
  Queue<int> queue = Queue<int>();
  int result = 1 << 30;

  for (int i = 0; i < graphFrom.length; i++) {
    final int from = graphFrom[i];
    final int to = graphTo[i];
    edges[from].add(to);
    edges[to].add(from);
  }

  for (int i = 0; i < ids.length; i++) {
    if (ids[i] == val) {
      dist[i + 1] = 0;
      src[i + 1] = i + 1;
      queue.addLast(i + 1);
    }
  }

  int next;
  Set<int> neighbSet;

  while (queue.isNotEmpty) {
    next = queue.removeFirst();
    neighbSet = edges[next];
    for (int neighbour in neighbSet) {
      // not visited yet, and not blue
      if (dist[neighbour] == -1) {
        src[neighbour] = src[next];
        dist[neighbour] = dist[next] + 1;
        queue.addLast(neighbour);
      }
      // already reached from another blue or another blue itself
      else if (src[next] != src[neighbour]) {
        final distance = dist[next] + 1 + dist[neighbour];
        if (distance < result) result = distance;
      }
    }
  }
  return result == 1 << 30 ? -1 : result;
}
