import 'package:flutter_test/flutter_test.dart';

class Solution {
  int longestMonotonicSubarray(List<int> nums) {
    if (nums.isEmpty) {
      return 0;
    }
    var maxInc = 1, maxDec = 1, currentInc = 1, currentDec = 1;
    for (var i = 1; i < nums.length; i++) {
      final number = nums[i];
      final prevNum = nums[i - 1];
      if (number > prevNum) {
        currentInc++;
        if (maxDec < currentDec) {
          maxDec = currentDec;
        }
        currentDec = 1;
      } else if (number < prevNum) {
        currentDec++;
        if (maxInc < currentInc) {
          maxInc = currentInc;
        }
        currentInc = 1;
      } else {
        if (maxInc < currentInc) {
          maxInc = currentInc;
        }
        currentInc = 1;
        if (maxDec < currentDec) {
          maxDec = currentDec;
        }
        currentDec = 1;
      }
    }
    if (maxInc < currentInc) {
      maxInc = currentInc;
    }
    if (maxDec < currentDec) {
      maxDec = currentDec;
    }

    return maxInc > maxDec ? maxInc : maxDec;
  }
}

void main() {
  final listExpected = [2, 1, 3, 2];
  final actualList = <int>[];
  test(
    '3105. Longest Strictly Increasing or Strictly Decreasing Subarray'
    '',
    () {
      final numberList = <List<int>>[
        [1, 4, 3, 3, 2],
        [3, 3, 3, 3],
        [3, 2, 1],
        [1, 1, 5],
      ];
      for (final list in numberList) {
        final result = Solution().longestMonotonicSubarray(list);
        // debugPrint(result.toString());
        actualList.add(result);
      }
    },
  );
  expect(actualList, listExpected);
}
