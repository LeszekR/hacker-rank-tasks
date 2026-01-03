Node lca(Node root, int v1, int v2) {
  Node next = root;
  int smaller, bigger;

  if(v1 < v2) {
    smaller = v1;
    bigger = v2;
  } else {
    smaller = v2;
    bigger = v1;
  }

  while (true) {
    if ((next.value >= smaller) && (next.value <= bigger)) {
      return next;
    } else if (next.value > smaller && next.value > bigger) {
      next = next.left!;
    } else {
      next = next.right!;
    }
  }
}

class Node{
  int value;
  Node? left;
  Node? right;
  Node(this.value, [this.left, this.right]);
}
