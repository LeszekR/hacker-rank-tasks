void testLexicographicalSmallestWithin() {
  print('egg: ${lexicographicalSmallestWithin('eggegg')}');
  print('agfedcb: ${lexicographicalSmallestWithin('abcdefgabcdefg')}');
}

String lexicographicalSmallestWithin(String A) {
  // count chars
  Map<String, Char> chars = {};
  String ch;
  for (int i = 0; i < A.length; i++) {
    ch = A.substring(i, i + 1);
    if (chars.keys.contains(ch)) {
      chars[ch]!.remains++;
    } else {
      chars[ch] = Char();
    }
  }

  // set required numbers
  for (Char char in chars.values) {
    char.required = (char.remains / 2).round();
  }

  // build the answer
  List<String> stack = [];
  for (int i = A.length - 1; i >= 0; i--) {
    ch = A.substring(i, i + 1);
    chars[ch]!.remains--;
    _updateStack(chars, stack, ch);
  }

  return stack.join();
}

void _updateStack(Map<String, Char> chars, List<String> stack, String ch) {
  String last;
  if (!chars[ch]!.full) {
    while (stack.isNotEmpty && stack.last.compareTo(ch) > 0 && chars[stack.last]!.remains > 0) {
      last = stack.removeLast();
      chars[last]!.used--;
    }
    stack.add(ch);
    chars[ch]!.used++;
  }
}

class Char {
  int remains = 1;
  int required = 0;
  int used = 0;

  bool get full => used == required;
}
