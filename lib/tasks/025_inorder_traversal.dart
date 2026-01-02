void testInorderTraversal() {
  inorderTraversal([]);
  inorderTraversal([8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15]);
}

void inorderTraversal(List<int> treeArray) {
  if (treeArray.isEmpty) return;

  _Node root = _buildTree(treeArray, 0)!;
  List<int> result = <int>[];

  _inorderLoop(root, result);
  print('loop  : ${result.toString()}');
  result.clear();
  _inorderRecurrent(root, result);
  print('recur : ${result.toString()}');
}

void _inorderLoop(_Node node, List<int> result) {
  List<_Node> stack = <_Node>[];
  _Node? next = node;

  while (next != null || stack.isNotEmpty) {
    while (next != null) {
      stack.add(next);
      next = next.left;
    }
    next = stack.removeLast();
    result.add(next.value);
    // print ('${next.value} ');
    next = next.right;
  }
}

void _inorderRecurrent(_Node? node, List<int> result) {
  if (node == null) return;
  _inorderRecurrent(node.left, result);
  result.add(node.value);
  // print('${node.value} ');
  _inorderRecurrent(node.right, result);
}

_Node? _buildTree(List<int> treeArray, int i) {
  if (treeArray.isEmpty) return null;
  if (i >= treeArray.length) return null;
  return _Node(treeArray[i], _buildTree(treeArray, i * 2 + 1), _buildTree(treeArray, i * 2 + 2));
}

class _Node {
  final int value;
  final _Node? left;
  final _Node? right;

  const _Node(this.value, this.left, this.right);
}
