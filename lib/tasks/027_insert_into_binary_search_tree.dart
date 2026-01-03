import '025_inorder_traversal.dart';

void testInsert() {
  List<int> result = [];

  var root = _build([10, 2, 20, 1, 3, 15, 30], 0);
  inorderLoop(root!, result);
  print(result.toString());

  var newRoot = insert(root, 8);
  result.clear();
  inorderLoop(newRoot, result);
  print(result.toString());

}

Node insert(Node? root, int data) {
  Node newNode = Node(data);

  if (root == null) return newNode;

  Node next = root;

  while (true) {
    if (data < next.value) {
      if (next.left == null) {
        next.left = newNode;
        break;
      } else {
        next = next.left!;
      }
    } else {
      if (next.right == null) {
        next.right = newNode;
        break;
      } else {
        next = next.right!;
      }
    }
  }

  return root;
}

Node? _build(List<int> arr, int i) {
  if (arr.isEmpty) return null;
  if (i >= arr.length) return null;
  return Node(arr[i], _build(arr, i * 2 + 1), _build(arr, i * 2 + 2));
}

class Node {
  final int value;
  Node? left;
  Node? right;

  Node(this.value, [this.left, this.right]);
}
