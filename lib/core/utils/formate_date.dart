import 'package:intl/intl.dart';

String formatDateOnly(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    return DateFormat(
      'yyyy-MM-dd',
    ).format(parsedDate); // أو 'dd MMM yyyy' لو عايز صيغة زي 27 Jul 2025
  } catch (e) {
    return 'غير محدد';
  }
}
