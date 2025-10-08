import 'dart:async';

import 'package:flutter/material.dart';

class ImageScrollAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ColorScheme colorScheme;
  final List<String> images;

  const ImageScrollAppBar({
    super.key,
    required this.colorScheme,
    required this.images,
  });

  @override
  State<ImageScrollAppBar> createState() => _ImageScrollAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(90); // total height
}

class _ImageScrollAppBarState extends State<ImageScrollAppBar> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      if (_scrollController.hasClients) {
        _scrollPosition += 1.5;
        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
        }
        _scrollController.jumpTo(_scrollPosition);
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: widget.colorScheme.primary,
        elevation: 6,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.colorScheme.primary,
                widget.colorScheme.primaryContainer.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 35, bottom: 10),
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white70],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: AssetImage(widget.images[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
