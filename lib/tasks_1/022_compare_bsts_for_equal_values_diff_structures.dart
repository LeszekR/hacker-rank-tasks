void testVerifySameMultisetDifferentStructure() {
  print(
    'true: ${verifySameMultisetDifferentStructure([4, 1, 6, 0, 2, 5, 7, null, null, null, 3], [4, 0, 5, null, 2, null, 7, null, null, 1, 3, null, null, 6])}',
  );
  print('false: ${verifySameMultisetDifferentStructure([1, 2, 3], [1, 2, 3, null, null])}');
  // print(verifySameMultisetDifferentStructure([1, 2, 4, null, 3, null], [1, 2, 3, null, null, null, 4]));
  // print(verifySameMultisetDifferentStructure([1, 2, 4, null, 3], [1, 2, 3, null, null, null, 4]));
}

bool verifySameMultisetDifferentStructure(List<int?> root1, List<int?> root2) {
  if (root1.isEmpty && root2.isEmpty) return false;
  if (root1.isEmpty != root2.isEmpty) return false;

  _Node? bst1 = _transform(root1, 0);
  _Node? bst2 = _transform(root2, 0);

  if (bst1 == null && bst2 == null) return false;
  if (bst1 == null || bst2 == null) return false;

  List<int?> values1 = _inorder(bst1);
  List<int?> values2 = _inorder(bst2);
  bool areValuesIdentical = _listEquals(values1, values2);

  bool areStructuresIdentical = _compareStructures(bst1, bst2);

  return areValuesIdentical && !areStructuresIdentical;
}

List<int?> _inorder(_Node bst) {
  List<int?> result = <int?>[];
  List<_Node> stack = <_Node>[];
  _Node? next = bst;

  do {
    while (next != null) {
      stack.add(next);
      next = next.left;
    }

    next = stack.removeLast();
    result.add(next.value);

    next = next.right;
  } while (stack.isNotEmpty || next != null);

  return result;
}

// List<int> _postorder(_Node bst) {
//   List<int> result = <int>[];
//   List<_Node> stack1 = <_Node>[bst];
//   List<_Node> stack2 = <_Node>[];
//
//   while (stack1.isNotEmpty) {
//     final next = stack1.removeLast();
//     stack2.add(next);
//     if (next.left != null) stack1.add(next.left!);
//     if (next.right != null) stack1.add(next.right!);
//   }
//
//   while (stack2.isNotEmpty) {
//     result.add(stack2.removeLast().value);
//   }
//   return result;
// }

_Node? _transform(List<int?> arr, int i) {
  if (i >= arr.length) return null;
  if (arr[i] == null) return null;
  var curr = arr[i]!;
  var left = _transform(arr, i * 2 + 1);
  var right = _transform(arr, i * 2 + 2);
  return _Node(curr, left, right);
}

class _Node {
  final int value;
  final _Node? left;
  final _Node? right;

  _Node(this.value, this.left, this.right);
}

bool _listEquals(List<int?> a, List<int?> b) {
  if (a == b) return true;
  if (a.length != b.length) return false;

  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _compareStructures(_Node bst1, _Node bst2) {
  List<_Node> stack1 = <_Node>[bst1];
  List<_Node> stack2 = <_Node>[bst2];
  _Node node1, node2;

  while(stack1.isNotEmpty && stack2.isNotEmpty) {
    node1 = stack1.removeLast();
    node2 = stack2.removeLast();

    if ((node1.left == null) != (node2.left == null)) return false;
    if ((node1.right == null) != (node2.right == null)) return false;

    if (node1.left != null) {
      stack1.add(node1.left!);
      stack2.add(node2.left!);
    }
    if (node1.right != null) {
      stack1.add(node1.right!);
      stack2.add(node2.right!);
    }
  }
  return stack1.isEmpty && stack2.isEmpty;
}
