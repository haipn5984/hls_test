import 'dart:io';

void main() {
  inputList();
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
