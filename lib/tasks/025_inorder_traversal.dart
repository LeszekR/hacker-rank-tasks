import '027_insert_into_binary_search_tree.dart';

void testInorderTraversal() {
  inorderTraversal([], true);
  inorderTraversal([8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15], true);
}

void inorderTraversal(List<int> treeArray, bool both) {
  if (treeArray.isEmpty) return;

  Node root = _buildTree(treeArray, 0)!;
  List<int> result = <int>[];

  inorderLoop(root, result);
  print('loop  : ${result.toString()}');
  result.clear();

  if (!both) return;

  _inorderRecurrent(root, result);
  print('recur : ${result.toString()}');
}

void inorderLoop(Node node, List<int> result) {
  List<Node> stack = <Node>[];
  Node? next = node;

  while (next != null || stack.isNotEmpty) {
    while (next != null) {
      stack.add(next);
      next = next.left;
    }
    next = stack.removeLast();
    result.add(next.value);
    next = next.right;
  }
}

void _inorderRecurrent(Node? node, List<int> result) {
  if (node == null) return;
  _inorderRecurrent(node.left, result);
  result.add(node.value);
  _inorderRecurrent(node.right, result);
}

Node? _buildTree(List<int> treeArray, int i) {
  if (treeArray.isEmpty) return null;
  if (i >= treeArray.length) return null;
  return Node(treeArray[i], _buildTree(treeArray, i * 2 + 1), _buildTree(treeArray, i * 2 + 2));
}

// class Node {
//   final int value;
//   final Node? left;
//   final Node? right;
//
//   const Node(this.value, this.left, this.right);
// }
