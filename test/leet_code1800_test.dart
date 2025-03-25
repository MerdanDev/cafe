import 'package:flutter_test/flutter_test.dart';

class Solution {
  int maxAscendingSum(List<int> nums) {
    if (nums.isEmpty) return 0;
    var maxAsc = 0;
    var currentAsc = nums.first;
    for (var i = 1; i < nums.length; i++) {
      final number = nums[i];
      final prevNum = nums[i - 1];
      if (number > prevNum) {
        currentAsc += number;
      } else {
        if (maxAsc < currentAsc) {
          maxAsc = currentAsc;
        }
        currentAsc = number;
      }
    }
    if (maxAsc < currentAsc) {
      maxAsc = currentAsc;
    }

    return maxAsc;
  }
}

void main() {
  test('1800. Maximum Ascending Subarray Sum', () {
    final expected = [65, 150, 33];
    final actual = <int>[];
    final testNumbers = [
      [10, 20, 30, 5, 10, 50],
      [10, 20, 30, 40, 50],
      [12, 17, 15, 13, 10, 11, 12],
    ];

    for (final numbers in testNumbers) {
      final result = Solution().maxAscendingSum(numbers);
      actual.add(result);
    }
    expect(actual, expected);
  });
}
