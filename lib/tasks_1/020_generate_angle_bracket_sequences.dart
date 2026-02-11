void testGenerateAngleBracketSequences() {
  print(generateAngleBracketSequences(4));
}

List<String> generateAngleBracketSequences(int n) {
  List<String> result = <String>[];

  List<_State> stack = List<_State>.empty(growable: true);
  stack.add(_State('', 0, 0));

  while (stack.isNotEmpty) {
    _State state = stack.removeLast();

    if (state.nOpening + state.nClosing == n * 2) {
      result.add(state.s);
      continue;
    }

    if (state.nClosing < state.nOpening) {
      stack.add(_State('${state.s}>', state.nOpening, state.nClosing + 1));
    }
    if (state.nOpening < n) {
      stack.add(_State('${state.s}<', state.nOpening + 1, state.nClosing));
    }
  }

  return result;
}

class _State {
  final String s;
  final int nOpening;
  final int nClosing;

  const _State(this.s, this.nOpening, this.nClosing);
}
