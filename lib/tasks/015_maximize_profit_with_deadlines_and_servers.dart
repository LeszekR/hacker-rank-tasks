import 'package:pathfinding/core/heap.dart';

void testMaximizeParallelTaskProfit() {
  print('60: ${maximizeParallelTaskProfit(1, [2, 1, 3], [20, 10, 30])}');
  print('118: ${maximizeParallelTaskProfit(2, [1, 1, 1, 2, 2, 3, 3], [10, 20, 5, 30, 25, 15, 18])}');
}

class _Task {
  final int profit;
  final int deadline;

  const _Task(this.profit, this.deadline);
}

int maximizeParallelTaskProfit(int m, List<int> deadlines, List<int> profits) {
  assert(deadlines.length == profits.length, 'deadlines and profits must be the same length');
  if (m < 1) return 0;

  int result = 0;
  final Heap heap = Heap((_Task a, _Task b) => b.profit.compareTo(a.profit));

  final List<_Task> tasks = <_Task>[for (int i = 0; i < deadlines.length; i++) _Task(profits[i], deadlines[i])];
  tasks.sort((a, b) => b.deadline.compareTo(a.deadline));

  final int maxDeadline = deadlines.reduce((a, b) => a > b ? a : b);

  int i = 0;
  for (int day = maxDeadline; day > 0; day--) {
    while (i < tasks.length && tasks[i].deadline == day) {
      heap.push(tasks[i]);
      i++;
    }
    for (int j = 0; j < m && !heap.empty(); j++) {
      result +=  (heap.pop() as _Task).profit;
    }
  }
  return result;
}

// class _Task {
//   final int profit;
//   final int deadline;
//   const _Task(this.profit, this.deadline);
// }
//
// int _profitComparator(_Task a, _Task b) {
//   if (a.profit < b.profit) return 1;
//   if (a.profit > b.profit) return -1;
//   return 0;
// }
//
// int maximizeParallelTaskProfit(int m, List<int> deadlines, List<int> profits) {
//   assert(profits.length == deadlines.length, 'profits and deadlines must have the same length');
//
//   int result = 0;
//   _Task next;
//   Heap heap = Heap(_profitComparator);
//
//   List<_Task> tasks = _makeTaskList(deadlines, profits);
//   deadlines = deadlines.toSet().toList();
//   deadlines.sort(); // sort ascending - the last element is biggest
//   int maxDeadline = deadlines[deadlines.length - 1];
//
//   for (int deadline = maxDeadline; deadline > 0; deadline--) {
//     for (_Task task in tasks) {
//       if (task.deadline == deadline) heap.push(task);
//     }
//     for (int j = 0; j < m && !heap.empty(); j++) {
//       next = heap.pop();
//       result += next.profit;
//     }
//   }
//   return result;
// }
//
// List<_Task> _makeTaskList(List<int> deadlines, List<int> profits) {
//   List<_Task> tasks = [];
//   for (int i = 0; i < deadlines.length; i++) {
//     tasks.add(_Task(profits[i], deadlines[i]));
//   }
//   return tasks;
// }
