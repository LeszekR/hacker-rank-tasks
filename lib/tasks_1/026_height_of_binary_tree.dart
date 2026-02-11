import 'dart:math';

void testHeight() {
  print(height(_build([10, 2, 20, 1, 3, 15, 30], 0)!).toString());
}

List<int> height(_Node root) {
  List<_Node> stack = <_Node>[root];
  int result = 0;
  _Node next;
  List<int> preorderArray = <int>[];

  while (stack.isNotEmpty) {
    next = stack.removeLast();
    result = max(result, next.distance);
    preorderArray.add(next.value);

    if (next.right != null) {
      next.right!.distance = next.distance + 1;
      stack.add(next.right!);
    }
    if (next.left != null) {
      next.left!.distance = next.distance + 1;
      stack.add(next.left!);
    }
  }
  return preorderArray;
}

_Node? _build(List<int> arr, int i) {
  if (arr.isEmpty) return null;
  if (i >= arr.length) return null;
  return _Node(arr[i], _build(arr, i * 2 + 1), _build(arr, i * 2 + 2));
}

class _Node {
  final int value;
  final _Node? left;
  final _Node? right;
  int distance = 0;

  _Node(this.value, this.left, this.right);
}
