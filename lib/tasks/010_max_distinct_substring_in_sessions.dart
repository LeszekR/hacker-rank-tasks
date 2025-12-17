void testMaxDistinctSubstringLengthInSessions() {
  print('6: ${maxDistinctSubstringLengthInSessions('aaabfdde"aa"bfdeeue""mkddfcghu')}');
  print('6: ${maxDistinctSubstringLengthInSessions('jkookjhhiojklhhnkj"ooopdfcgga')}');
  print('0: ${maxDistinctSubstringLengthInSessions("*")}');
  print('1: ${maxDistinctSubstringLengthInSessions('aa')}');
}

int maxDistinctSubstringLengthInSessions(String sessionString) {
  Map<String, bool> found = {};
  int maxLength = 0;
  int currLength = 0;
  String next;

  for (int i = 0; i < sessionString.length; i++) {
    next = sessionString[i];

    if (RegExp('([a-z]|")').hasMatch(next)) {
      if (next == '"') {
        maxLength = currLength > maxLength ? currLength : maxLength;
        found.clear();
        currLength = 0;
      } else if (found.keys.contains(next)) {
        maxLength = currLength > maxLength ? currLength : maxLength;
        found.clear();
        found[next] = true;
        currLength = 1;
      } else {
        found[next] = true;
        currLength++;
      }
    }
  }
  maxLength = currLength > maxLength ? currLength : maxLength;
  return maxLength;
}
