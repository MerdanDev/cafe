import 'package:flutter_test/flutter_test.dart';

class Solution {
  List<List<(int, int, int)>> getStack(List<List<int>> grid) {
    final pathStack = List.generate(
      grid[0].length,
      (index) => <(int, int, int)>[],
    );

    for (var i = 0; i < grid[0].length; i++) {
      for (var j = 0; j <= i; j++) {
        pathStack[i].add((0, j, grid[0][j]));
      }

      for (var j = i; j < grid[0].length; j++) {
        pathStack[i].add((1, j, grid[1][j]));
      }
    }
    return pathStack;
  }

  (int, int) getRobotPath(List<List<(int, int, int)>> pathStack) {
    return pathStack
        .map((e) => e.map((e) => e.$3))
        .map((e) => e.reduce((value, element) => value + element))
        .indexed
        .reduce(
          (value, element) => value.$2 > element.$2 ? value : element,
        );
  }

  int gridGame8(List<List<int>> grid) {
    final pathStack = getStack(grid);
    final firstRobotPath = getRobotPath(pathStack);

    print(
      pathStack[firstRobotPath.$1].map(
        (e) => e.$3.toString().padLeft(2, '0'),
      ),
    );

    print(
      grid
          .map(
            (e) => e.map(
              (e) => e.toString().padLeft(2, '0'),
            ),
          )
          .join('\n'),
    );
    for (var i = 0; i < pathStack[firstRobotPath.$1].length; i++) {
      final item = pathStack[firstRobotPath.$1][i];
      grid[item.$1][item.$2] = 0;
    }

    print(
      grid
          .map(
            (e) => e.map(
              (e) => e.toString().padLeft(2, '0'),
            ),
          )
          .join('\n'),
    );

    final reducedStack = getStack(grid);

    final secondRobotPath = getRobotPath(reducedStack);

    print(
      reducedStack[secondRobotPath.$1].map(
        (e) => e.$3.toString().padLeft(2, '0'),
      ),
    );

    return secondRobotPath.$2;
  }

  int gridGame78(List<List<int>> grid) {
    final sumList = <int>[];
    for (var i = 0; i < grid[0].length; i++) {
      final firstRange = grid[0].getRange(i + 1, grid[0].length);
      final secondRange = grid[1].getRange(0, i);
      final int first;
      final int second;
      if (firstRange.isNotEmpty) {
        first = firstRange.reduce((a, b) => a + b);
      } else {
        first = 0;
      }

      if (secondRange.isNotEmpty) {
        second = secondRange.reduce((a, b) => a + b);
      } else {
        second = 0;
      }
      sumList.add(first <= second ? second : first);
    }

    return sumList.reduce((a, b) => a <= b ? a : b);
  }

  int gridGame(List<List<int>> grid) {
    final n = grid[0].length;

    // Compute prefix sums for both rows
    final topPrefixSum = List<int>.filled(n + 1, 0);
    final bottomPrefixSum = List<int>.filled(n + 1, 0);

    for (var i = 0; i < n; i++) {
      topPrefixSum[i + 1] = topPrefixSum[i] + grid[0][i];
      bottomPrefixSum[i + 1] = bottomPrefixSum[i] + grid[1][i];
    }
    print(topPrefixSum);
    print(bottomPrefixSum);

    var minSecondRobotPoints = double.maxFinite.toInt();

    // Simulate first robot's path
    for (var col = 0; col < n; col++) {
      // Points left for second robot
      final pointsTop = topPrefixSum[n] -
          topPrefixSum[col + 1]; // Remaining points in top row
      final pointsBottom =
          bottomPrefixSum[col]; // Points in bottom row up to current column

      // Second robot's maximum points if first robot switches rows at `col`
      final secondRobotPoints =
          (pointsTop > pointsBottom) ? pointsTop : pointsBottom;

      print(secondRobotPoints);

      // Minimize second robot's maximum points
      minSecondRobotPoints = (minSecondRobotPoints > secondRobotPoints)
          ? secondRobotPoints
          : minSecondRobotPoints;
    }

    return minSecondRobotPoints;
  }
}

void main() {
  test('2017 leet code', () {
    final result = Solution().gridGame([
      [20, 03, 20, 17, 02, 12, 15, 17, 04, 15],
      [20, 10, 13, 14, 15, 05, 02, 03, 14, 03],
    ]);
    print(result);
    expect(result, 63);
  });
}
