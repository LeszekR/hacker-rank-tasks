import 'dart:collection';
import 'dart:math';

import 'package:collection/collection.dart';

(int, int) findSmallestSubstringWindow(List<String> patternList, String S) {
  _Substring result = _Substring(-1, -1);

  if (patternList.length == 0 || S.length == 0) return (-1, -1);

  List<_Pattern> patterns = [];
  for (int i = 0; i < patternList.length; i++) {
    patterns.add(_Pattern(i, patternList[i]));
  }

  for (_Pattern pattern in patterns) {
    _fillLps(pattern);
    _findOccurrencesWithKMP(S, pattern);
  }

  _Substring? nextSubstring;
  int lastIndex = -1;
  int currLength;
  bool hasAllPatterns = true;
  PriorityQueue<_Substring> heap = PriorityQueue<_Substring>((a, b) => (a.startIndex).compareTo(b.startIndex));

  for (_Pattern pattern in patterns) {
    nextSubstring = pattern.popFirst();

    // this pattern has not been found in S
    if (nextSubstring == null) {
      return (result.startIndex, result.endIndex);
    }

    // push the first one of each pattern on the heap
    else {
      heap.add(nextSubstring);
      lastIndex = max(lastIndex, nextSubstring.endIndex);
    }
  }

  while (hasAllPatterns) {
    nextSubstring = heap.removeFirst();
    currLength = lastIndex - nextSubstring!.startIndex + 1;
    if (currLength < result.length) {
      result = _Substring(nextSubstring.startIndex, lastIndex);
    }

    nextSubstring = patterns[nextSubstring.myIndex!].popFirst();

    if (nextSubstring == null) {
      hasAllPatterns = false;
    } else {
      heap.add(nextSubstring);
      lastIndex = max(lastIndex, nextSubstring.endIndex);
    }
  }
  return (result.startIndex, result.endIndex);
}

class _Pattern {
  final int myIndex;
  final String s;
  List<int> lps = [];
  final Queue<_Substring> _occurrences = Queue<_Substring>();

  _Pattern(this.myIndex, this.s) {
    lps = List<int>.filled(s.length, 0);
  }

  _Substring? popFirst() {
    if (_occurrences.isEmpty) return null;
    return _occurrences.removeFirst();
  }

  void addLast(_Substring s) => _occurrences.addLast(s);
}

class _Substring {
  final int? myIndex;
  final int startIndex;
  final int endIndex;

  const _Substring(this.startIndex, this.endIndex, [this.myIndex]);

  int get length {
    if (startIndex == -1) return 10000000;
    return endIndex - startIndex + 1;
  }
}

// KMP
// —-------------------------------------
// TODO - unfinished - finish this
void _fillLps(_Pattern pattern) {
  String s = pattern.s;
  if (s.isEmpty) return;
  int len = 0;
  int i = 1;
  while (i < pattern.s.length) {
    if (s[i] == s[len]) {
      len++;
      pattern.lps[i] = len;
      i++;
    }
    else if (len > 0) {
      len = pattern.lps[len - 1];
    }
    else {
      pattern.lps[i] = 0;
      i++;
    }
  }
}

// TODO - unfinished - finish this
void _findOccurrencesWithKMP(String S, _Pattern pattern) {
  String s = pattern.s;
  List<int> lps = pattern.lps;
  int j = 0,
      i = 0;
  while (i < S.length) {
    if (S[i] == s[j]) {
      if (j == s.length - 1) {
        pattern.addLast(_Substring(i - j, i, pattern.myIndex));
        j = lps[j];
      } else {
        j++;
        i++;
      }
    }
    else {
      j = lps[j - 1];
    }
  }
}
