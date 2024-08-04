import 'dart:io';

void main() {
  clearScreen();
  listProcess(inputList());
}

List<int> inputList([retry = false]) {
  try {
    if (retry) print('The list you entered is invalid, please re-enter it!');
    print('Enter five, posotive intergrs,each number separated by space');
    String? input = stdin.readLineSync();
    final list = <int>[];
    input?.split(' ').forEach(
      (element) {
        if (element.trim() != '') list.add(int.parse(element.trim()));
      },
    );
    if (list.length == 5) {
      print('Input list: $list');
      return list;
    } else {
      return inputList(true);
    }
  } catch (e) {
    return inputList(true);
  }
}

void clearScreen() {
  if (Platform.isWindows) {
    print(Process.runSync('cls', [], runInShell: true).stdout);
  } else {
    print(Process.runSync('clear', [], runInShell: true).stdout);
  }
}

double getSum(List<int> input, {int numberOfE = 4}) {
  double sum = 0;
  for (var i = 0; i < numberOfE; i++) {
    sum += input[i];
  }
  return sum;
}

void listProcess(List<int> list) {
  list.sort();
  sumCalculate(list);
  listInfo(list);
}

void sumCalculate(List<int> list) {
  try {
    print('Minimum sum of 4 of 5 elements: ${getSum(list)}');
    print('Maximum sum of 4 of 5 elements: ${getSum(
      list.reversed.toList(),
    )}');
  } catch (e) {
    print(e);
  }
}

void listInfo(List<int> list) {
  try {
    final total = getSum(list, numberOfE: 5);
    print('Total of array $total');

    final min = list.first;
    print('Min in array $min');

    final max = list.last;
    print('Max in array $max');

    List<int> evenE = list.where((element) => element % 2 == 0).toList();
    print('Even elements: $evenE');

    List<int> oddE = list.where((element) => element % 2 != 0).toList();
    print('Odd elements $oddE');
  } catch (e) {
    print(e);
  }
}
