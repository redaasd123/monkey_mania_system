import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/layers_entity.dart';

class ItemLayer1A2 extends StatelessWidget {
  const ItemLayer1A2({
    super.key,
    required this.imagePath,
    required this.item,
  });

  final String imagePath;
  final LayersEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // الصورة
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        // النص
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}