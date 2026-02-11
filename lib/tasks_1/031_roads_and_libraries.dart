import 'dart:collection';

void testRoadsAndLibraries() {
  print(
    roadsAndLibraries(6, 100, 1, [
      [1, 3],
      [3, 4],
      [2, 4],
      [1, 2],
      [2, 3],
      [5, 6],
    ]),
  );
}

int roadsAndLibraries(int n, int cLib, int cRoad, List<List<int>> cities) {
  if (cLib <= cRoad) return n * cLib;

  List<_City> cityList = _make_CityList(cities, n);
  List<int> treeSizes = <int>[];

  for (_City city in cityList) {
    if (city.isConnected) continue;
    treeSizes.add(_bfs(cityList, city));
  }

  int result = 0;
  result += treeSizes.length * cLib;
  result += (treeSizes.reduce((a, b) => a + b) - treeSizes.length) * cRoad;
  return result;
}

int _bfs(List<_City> cityList, _City city) {
  var queue = Queue<_City>();
  _City next;
  int result = 0;

  result += _connect(queue, city);

  while (queue.isNotEmpty) {
    next = queue.removeFirst();
    for (int id in next.roads) {
      result += _connect(queue, cityList[id]);
    }
  }
  return result;
}

int _connect(Queue<_City> queue, _City city) {
  if (city.isConnected) return 0;
  city.isConnected = true;
  queue.addLast(city);
  return 1;
}

List<_City> _make_CityList(List<List<int>> cities, int n) {
  List<_City> cityList = List<_City>.generate(n, (i) => _City());
  int id;

  for (List<int> city in cities) {
    cityList[city[0] - 1].roads.add(city[1] - 1);
    cityList[city[1] - 1].roads.add(city[0] - 1);
  }
  return cityList;
}

class _City {
  final Set<int> roads = <int>{};
  bool isConnected = false;

  _City();
}
