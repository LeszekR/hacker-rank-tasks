import 'dart:math';

void testCommonChild(){
  print('3: ${commonChild('ABCD', 'ABDC')}');
  print('4: ${commonChild('ABCDACEF', 'ABDC')}');
}

int commonChild(String a, String b) {
  int n = a.length;
  int m = b.length;
  List<List<int>> tab = List<List<int>>.filled(n + 1, List<int>.filled(m+1, 0));

  for (int i = 1; i < n + 1; i++) {
    for (int j = 1; j < m + 1; j++) {
      if(a[i-1] == b[j-1]) {
        tab[i][j] = tab[i-1][j-1] + 1;
      } else {
        tab[i][j] = max(tab[i-1][j], tab[i][j-1]);
  }
  }
  }
  return tab[n][m];
}
