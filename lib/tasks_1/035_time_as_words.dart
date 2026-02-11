void testTimeInWords() {
  var r = (int a, int b) => ((a & b) ^ (a | b)) & (a ^ b);
  print ('9,6: ${r(9,6)}');
  print ('15,12: ${r(15,12)}');
  print ('15,13: ${r(15,13)}');
  print ('111,1288: ${r(111,1288)}');

  String time;
  time = '12:00';
  print('$time ${timeInWords(time)}');
  time = '5:15';
  print('$time ${timeInWords(time)}');
  time = '11:45';
  print('$time ${timeInWords(time)}');
  time = '4:30';
  print('$time ${timeInWords(time)}');
  time = '6:12';
  print('$time ${timeInWords(time)}');
  time = '6:27';
  print('$time ${timeInWords(time)}');
  time = '6:39';
  print('$time ${timeInWords(time)}');
  time = '11:59';
  print('$time ${timeInWords(time)}');
  time = '31:69';
  print('$time ${timeInWords(time)}');
}

String timeInWords(String time) {
  List<String> parts = time.split(':');
  int hour = int.parse(parts[0]);
  int min = int.parse(parts[1]);

  String hourStr = _numberToWords(hour);

  String minStr;
  if (min == 0)
    minStr = '# o\' clock';
  else if (min == 15)
    minStr = 'a quarter past #';
  else if (min == 45)
    minStr = 'a quarter to #';
  else if (min == 30)
    minStr = 'half past #';
  else if (min < 30 && min > 0)
    minStr = '${_numberToWords(min)} past #';
  else if (min > 30 && min < 60)
    minStr = '${_numberToWords(60 - min)} to #';
  else
    throw Exception('Incorrect minutes: $min');

  return minStr.replaceAll('#', hourStr);
}

String _numberToWords(int hour) {
  return switch (hour) {
    0 => 'twelve',
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    _ => switch (hour ~/ 10) {
      2 => 'twenty ${_numberToWords(hour % 10)}',
      3 => 'thirty ${_numberToWords(hour % 10)}',
      4 => 'forty ${_numberToWords(hour % 10)}',
      5 => 'fifty ${_numberToWords(hour % 10)}',
      6 => 'sixty ${_numberToWords(hour % 10)}',
      _ => throw Exception('Incorrect minutes: $hour'),
    },
  };
}
