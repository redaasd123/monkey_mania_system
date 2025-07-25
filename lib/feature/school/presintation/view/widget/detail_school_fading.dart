import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailSchoolFading extends StatelessWidget {
  const DetailSchoolFading({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔸 أقصى عرض للبطاقة (يمكنك ضبط النسبة كما تريد)
    final maxW = MediaQuery.of(context).size.width * .45;

    // 🔸 أداة مختصرة لإنشاء مستطيل رمادي مموّه (سطر وهمي)
    Widget line(double h, double w) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(6),
      ),
    );

    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outlineVariant,
      highlightColor: Theme.of(context).colorScheme.outline,
      period: const Duration(milliseconds: 1800),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.yellow.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: maxW,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                line(22, maxW),          // 🧒 العنوان (اسم المدرسة)
                const SizedBox(height: 8),
                line(16, maxW * .8),     // 🗺️ العنوان
                const SizedBox(height: 8),
                line(16, maxW * .7),     // 📝 الملاحظة
                const SizedBox(height: 12),
                Row(
                  children: [
                    line(14, 70),         // 🕒 الوقت
                    const SizedBox(width: 8),
                    // أيقونة الوقت بنفس لون الخطّ الوهمي
                    Icon(Icons.access_time,
                        color: Theme.of(context).colorScheme.outlineVariant),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: line(14, 90),   // 🐵 اسم الشركة
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
