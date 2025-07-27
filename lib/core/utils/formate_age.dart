String formatAge(DateTime birthDate) {
  final now = DateTime.now();
  int years = now.year - birthDate.year;
  int months = now.month - birthDate.month;
  int days = now.day - birthDate.day;

  if (days < 0) {
    final previousMonth = DateTime(now.year, now.month, 0);
    days += previousMonth.day;
    months -= 1;
  }

  if (months < 0) {
    months += 12;
    years -= 1;
  }

  final parts = <String>[];
  if (years > 0) parts.add('$years سنة');
  if (months > 0) parts.add('$months شهر');
  if (days > 0) parts.add('$days يوم');

  return parts.isEmpty ? 'أقل من يوم' : parts.join(' و ');
}
