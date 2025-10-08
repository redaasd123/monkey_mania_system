import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'langs_key.dart';

class CustomPopupMenu extends StatelessWidget {
  final Function()? onDownload;
  final Function()? onBranch;

  const CustomPopupMenu({super.key, this.onDownload, this.onBranch});

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuEntry<String>> items = [];
    if (onBranch != null) {
      items.add(
        PopupMenuItem<String>(
          value: 'Filters',
          child: Row(
            children: [
              Icon(
                Icons.store_mall_directory,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                LangKeys.filters.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (onDownload != null) {
      items.add(
        PopupMenuItem<String>(
          value: 'download',
          child: Row(
            children: [
              Icon(
                Icons.download,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                LangKeys.download.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PopupMenuButton<String>(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]!.withOpacity(0.95)
          : Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 10,
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF004953), Color(0xFF004953)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child:  Text(
          LangKeys.actions.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onSelected: (value) {
        if (value == 'Filters' && onBranch != null) {
          onBranch!();
        } else if (value == 'download' && onDownload != null) {
          onDownload!();
        }
      },
      itemBuilder: (context) => items,
    );
  }
}



