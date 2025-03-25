import 'package:flutter_test/flutter_test.dart';

class Solution {
  List<int> findThePrefixCommonArray(List<int> A, List<int> B) {
    final bucket = <int>{};
    final result = <int>[];
    for (var i = 0; i < A.length; i++) {
      bucket
        ..add(A[i])
        ..add(B[i]);
      result.add((i + 1) * 2 - bucket.length);
    }

    return result;
  }
}

void main() {
  test('Leet code test', () {
    final A = [1, 3, 2, 4];
    final B = [3, 1, 2, 4];
    final result = Solution().findThePrefixCommonArray(A, B);

    expect(result, [0, 2, 3, 4]);
  });
}
