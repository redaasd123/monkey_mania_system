import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final Function()? onDownload;
  final Function()? onBranch;

  const CustomPopupMenu({super.key, this.onDownload, this.onBranch});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]!.withOpacity(0.95)
          : Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 10,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFC971E4), Color(0xFFC0A7C6)],
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
        child: const Icon(Icons.more_vert, color: Colors.white, size: 22),
      ),
      onSelected: (value) async {
        if (value == 'branch') {
          if (onBranch != null) onBranch!();
        } else if (value == 'download') {
          if (onDownload != null) onDownload!();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'branch',
          child: Row(
            children: [
              Icon(
                Icons.store_mall_directory,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                'Branch',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
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
                'Download',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
