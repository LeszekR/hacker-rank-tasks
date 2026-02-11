void testAbbreviation() {
  print ('YES: ${abbreviation('AbcDE', 'ABDE')}');
  print ('YES: ${abbreviation('daBcd', 'ABC')}');
  print ('NO: ${abbreviation('daBBcd', 'ABC')}');
  print ('YES: ${abbreviation('daBfcd', 'ABC')}');
  print ('YES: ${abbreviation('aB', 'AB')}');
  print ('YES: ${abbreviation('bA', 'A')}');
  print ('YES: ${abbreviation('abC', 'ABC')}');
  print ('NO: ${abbreviation('aB', 'A')}');
}

String abbreviation(String a, String b) {
  List<String> text = a.split('');
  List<String> abbrev = b.toUpperCase().split('');

  String curr;
  bool didUpdatePrefix;
  int prefixStart = 0;
  int nextCharIndex = 0;
  String searchedChar;

  bool updatePrefix(String curr) {
    for (int k = prefixStart; k < nextCharIndex; k++) {
      if (curr.compareTo(abbrev[k]) == 0) {
        nextCharIndex = k + 1;
        prefixStart = nextCharIndex;
        return true;
      }
    }
    return false;
  }

  bool hasMoreCapitals(int lastCheckedIndex){
    for (int i = lastCheckedIndex + 1; i < text.length; i++) {
      if (isUpperCase(text[i])) return true;
    }
    return false;
  }

  for (int i = 0; i < text.length; i++) {
    searchedChar = abbrev[nextCharIndex];
    curr = text[i];

    // found the searched char in upper case
    if (curr.compareTo(searchedChar) == 0) {
      nextCharIndex++;
      prefixStart = nextCharIndex;
    }
    // found the searched char in lower case
    else if (curr.compareTo(searchedChar.toLowerCase()) == 0){
      nextCharIndex++;
    }
    // found other char in upper case
    else if (isUpperCase(curr)) {
      didUpdatePrefix = updatePrefix(curr);
      if (!didUpdatePrefix) break;
    }
    // found other char in lower case - do nothing

    // reached the end of the abbreviation
    if (nextCharIndex == abbrev.length) {
      if (hasMoreCapitals(i)) {
        return "NO";
      }
      return "YES";
    }
  }
  return "NO";
}

bool isUpperCase(String c) {
  final int code = c.codeUnitAt(0);
  return code >= 65 && code <= 90;
}
