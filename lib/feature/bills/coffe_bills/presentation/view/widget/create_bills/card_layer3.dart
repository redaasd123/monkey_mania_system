import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/get_all_layers_entity.dart';

class CardLayer3Widget extends StatelessWidget {
  const CardLayer3Widget({
    super.key,
    required this.imagePath,
    required this.item,
  });

  final String imagePath;
  final GetAllLayerEntity item;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الصورة
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          // النصوص
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  item.product ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${item.price} ج.م",
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "متاح: ${item.availableUnits}",
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}