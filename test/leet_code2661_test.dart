import 'package:flutter_test/flutter_test.dart';

class Solution {
  int firstCompleteIndex(List<int> arr, List<List<int>> mat) {
    final col = <List<int>>[];
    for (var i = 0; i < mat[0].length; i++) {
      col.add([]);
      for (var j = 0; j < mat.length; j++) {
        col[i].add(mat[j][i]);
      }
    }
    print(col);
    for (var i = 0; i < arr.length; i++) {
      for (var j = 0; j < col.length; j++) {
        col[j].removeWhere((element) => element == arr[i]);
        if (col[j].isEmpty) {
          return i;
        }
      }

      for (var j = 0; j < mat.length; j++) {
        mat[j].removeWhere((element) => element == arr[i]);
        if (mat[j].isEmpty) {
          return i;
        }
      }
    }

    return 0;
  }

  int firstCompleteIndex2(List<int> arr, List<List<int>> mat) {
    final m = mat.length;
    final n = mat[0].length;
    final col = List.filled(n, 0); // column
    final row = List.filled(m, 0); // row
    final pos = List.generate(
      arr.length + 1,
      (_) => (0, 0),
    ); // positions of the number in the arr
    // fill the 'pos'
    for (var r = 0; r < m; r++) {
      for (var c = 0; c < n; c++) {
        pos[mat[r][c]] = (r, c);
      }
    }
    print(pos);
    // count row and columns
    for (var i = 0; i < arr.length; i++) {
      final (r, c) = pos[arr[i]];
      if (++row[r] == n) return i;
      if (++col[c] == m) return i;
    }
    return 0;
  }

  int firstCompleteIndex3(List<int> arr, List<List<int>> mat) {
    final r = mat.length;
    final c = mat[0].length;

    final row = List<int>.generate(r, (index) => c);
    final col = List<int>.generate(c, (index) => r);

    final position = List<List<int>>.generate((r * c) + 1, (index) => [0, 0]);

    for (var i = 0; i < r; i++) {
      for (var j = 0; j < c; j++) {
        position[mat[i][j]] = [i, j];
      }
    }

    var index = 0;
    for (final n in arr) {
      final pos = position[n];
      final rowIdx = pos[0];
      final colIdx = pos[1];

      // Decrement counts
      row[rowIdx]--;
      col[colIdx]--;

      // Check if any row or column is completely marked
      if (row[rowIdx] == 0 || col[colIdx] == 0) return index;

      index++;
    }

    return -1; // If no complete row or column is found
  }
}

void main() {
  test('Leet code test 2661', () {
    final result = Solution().firstCompleteIndex2(
      [2, 8, 7, 4, 1, 3, 5, 6, 9],
      [
        [3, 2, 5],
        [1, 4, 6],
        [8, 7, 9],
      ],
    );
    expect(result, 3);
  });
}
