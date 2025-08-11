import 'package:flutter/material.dart';

class DetailSchoolFading extends StatelessWidget {
  const DetailSchoolFading({super.key});

  @override
  Widget build(BuildContext context) {
    final maxW = MediaQuery.of(context).size.width * .45;

    Widget line(double h, double w) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.grey, // عادي لأن Skeletonizer هيعدله
        borderRadius: BorderRadius.circular(6),
      ),
    );

    return Card(
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
              line(22, maxW),
              const SizedBox(height: 8),
              line(16, maxW * .8),
              const SizedBox(height: 8),
              line(16, maxW * .7),
              const SizedBox(height: 12),
              Row(
                children: [
                  line(14, 70),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.access_time,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(alignment: Alignment.bottomRight, child: line(14, 90)),
            ],
          ),
        ),
      ),
    );
  }
}
