import 'package:intl/intl.dart';

String formatDateOnly(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    return DateFormat(
      'yyyy-MM-dd',
    ).format(parsedDate);
  } catch (e) {
    return 'غير محدد';
  }
}
