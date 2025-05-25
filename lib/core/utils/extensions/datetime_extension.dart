extension DateExtension on DateTime {
  bool get isToday {
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day;
  }

  bool get isYesterday {
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day - 1;
  }

  bool get isTomorrow {
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day + 1;
  }

  DateTime addYears(int amount) => DateTime(year + amount, month, day, hour, minute, second);
  DateTime addMonths(int amount) => DateTime(year, month + amount, day, hour, minute, second);
  DateTime addDays(int amount) => add(Duration(days: amount));
  DateTime addHours(int amount) => add(Duration(hours: amount));

  DateTime get nextHour => addHours(1);
  DateTime get previousHour => addHours(-1);

  DateTime get nextDay => addDays(1);
  DateTime get previousDay => addDays(-1);

  DateTime get previousWeek => addDays(-7);
  DateTime get nextWeek => addDays(7);

  DateTime get nextYear => addYears(1);
  DateTime get previousYear => addYears(-1);

  bool isSameDayAs(DateTime b) => year == b.year && month == b.month && day == b.day;

  bool get isFirstDayOfMonth => isSameDayAs(firstDayOfMonth);
  bool get isLastDayOfMonth => isSameDayAs(lastDayOfMonth);

  DateTime get firstDayOfMonth => DateTime(year, month);
  DateTime get lastDayOfMonth {
    final beginningNextMonth = (month < 12) ? DateTime(year, month + 1) : DateTime(year + 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  DateTime get previousMonth {
    var year = this.year;
    var month = this.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  DateTime get nextMonth {
    var year = this.year;
    var month = this.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  DateTime startOfWeek({required bool isSundayFirst}) {
    return subtract(Duration(days: (weekday % 7) - (isSundayFirst ? 0 : 1)));
  }

  bool isSameWeek(DateTime b) {
    final a = DateTime.utc(year, month, day);
    final adjustedB = DateTime.utc(b.year, b.month, b.day);

    final diff = a.toUtc().difference(adjustedB.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }
    final aBeforeB = a.isBefore(adjustedB);
    final min = aBeforeB ? a : adjustedB;
    final max = aBeforeB ? adjustedB : a;
    final result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }
}
