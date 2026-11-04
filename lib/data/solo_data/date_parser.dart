import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

enum BDateMode {
  relativeDate,           // "Сегодня", "Вчера", "Завтра" или "24.05.2024"
  timeOnly,               // "14:30"
  fullDateTime,           // "Сегодня, 14:30" или "24.05.2024, 14:30"
  dateOnly,               // Строго дата: "24.05.2024"
  relativeShortMonthTime, // "Сегодня, 12:20" или "24 авг, 12:40"
}

class BDateParser {
  static String format({required String rawDate,required BDateMode mode,required BuildContext context}) {
    // toLocal() переводит время из UTC (как отдает Supabase) в часовой пояс телефона
    final DateTime? date = DateTime.tryParse(rawDate)?.toLocal();
    if (date == null) return rawDate;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final itemDate = DateTime(date.year, date.month, date.day);

    // Время ЧЧ:ММ
    final String time = DateFormat('HH:mm').format(date);

    // Дата ДД.ММ.ГГГГ
    final String dateString = DateFormat('dd.MM.yyyy').format(date);

    // Относительный день на русском
    String relativeDay = dateString;
    if (itemDate == today) {
      relativeDay = 'Сегодня';
    } else if (itemDate == yesterday) {
      relativeDay = 'Вчера';
    } else if (itemDate == tomorrow) {
      relativeDay = 'Завтра';
    }

    switch (mode) {
      case BDateMode.relativeDate:
        return relativeDay;

      case BDateMode.timeOnly:
        return time;

      case BDateMode.fullDateTime:
        return '$relativeDay, $time';

      case BDateMode.dateOnly:
        return dateString;

      case BDateMode.relativeShortMonthTime:
        if (itemDate == today || itemDate == yesterday || itemDate == tomorrow) {
          return '$relativeDay, $time';
        }

        // Месяцы на русском без лишних зависимостей:
        const months = [
          'янв', 'фев', 'мар', 'апр', 'мая', 'июн',
          'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
        ];
        final String shortDate = '${date.day} ${months[date.month - 1]}';
        return '$shortDate, $time';
    }
  }
}