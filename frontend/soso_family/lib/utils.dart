import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
    // 3일 후에 대한 이벤트
    kToday.add(const Duration(days: 3)): [
      const Event('이벤트 A'),
    ],
    // 5일 후에 대한 이벤트
    kToday.add(const Duration(days: 5)): [
      const Event('이벤트 B'),
      const Event('이벤트 C'),
    ],
    // 7일 후에 대한 이벤트
    kToday.add(const Duration(days: 7)): [
      const Event('이벤트 D'),
      const Event('이벤트 E'),
      const Event('이벤트 F'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
