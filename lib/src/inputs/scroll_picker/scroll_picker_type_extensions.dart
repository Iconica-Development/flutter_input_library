// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

class TypeUtils {
  /// Creates list of Datetime with days. These fall on the respective week
  /// days from start to end.
  List<DateTime> createWeekDays(
    WeekDay start,
    WeekDay end,
  ) {
    if (start.index > end.index) {
      throw ArgumentError("Start month must be before or equal to end month.");
    }

    var result = <DateTime>[];
    for (var i = start.index; i <= end.index; i++) {
      result.add(DateTime(2024, 1, WeekDay.values[i].index + 1));
    }

    return result;
  }

  /// Creates list of Datetime with the months from start to end.
  List<DateTime> createMonthList(Month start, Month end, {int? year}) {
    if (start.index > end.index) {
      throw ArgumentError("Start month must be before or equal to end month.");
    }

    var result = <DateTime>[];
    for (var i = start.index; i <= end.index; i++) {
      result.add(
        DateTime(year ?? DateTime.now().year, Month.values[i].index + 1, 1),
      );
    }

    return result;
  }

  /// Creates a list of Datetime with the years from start to end.
  List<DateTime> createYearList(int start, int end) {
    if (start > end) {
      throw ArgumentError("Start year must be before or equal to year month.");
    }

    var result = <DateTime>[];
    for (var i = 0; i <= end - start; i++) {
      result.add(DateTime(start + i, 1, 1));
    }

    return result;
  }
}
