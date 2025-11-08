import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/styles.dart';
import 'owner_list_view.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.userDataFromChat,
    this.lastUpdate,
  });

  final UserDataFromChat userDataFromChat;
  final Timestamp? lastUpdate;

  bool get isOnline {
    if (lastUpdate == null) return false;
    final now = DateTime.now();
    final diff = now.difference(lastUpdate!.toDate());
    return diff.inSeconds < 15;
  }

  String getLastSeenText() {
    if (lastUpdate == null) return "Offline";
    final lastSeen = lastUpdate!.toDate();
    final now = DateTime.now();

    if (isOnline) {
      return "Online";
    } else if (now.day == lastSeen.day &&
        now.month == lastSeen.month &&
        now.year == lastSeen.year) {
      return "last seen  ${DateFormat('HH:mm').format(lastSeen)}";
    } else {
      return "last seen  ${DateFormat('MMM d, HH:mm').format(lastSeen)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusText = getLastSeenText();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.8,
      toolbarHeight: 60.h,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Image.asset(
                    userDataFromChat.image,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 4.h,
                  right: 4.w,
                  child: Container(
                    height: 10.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5.w),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userDataFromChat.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  statusText,
                  style: TextStyle(
                    color: isOnline ? Colors.teal : Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam_outlined, color: Colors.black87),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.call_outlined, color: Colors.black87),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black87),
          onSelected: (value) {},
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'view', child: Text('View contact')),
            PopupMenuItem(
              value: 'media',
              child: Text('Media, links, and docs'),
            ),
            PopupMenuItem(value: 'search', child: Text('Search')),
            PopupMenuItem(value: 'mute', child: Text('Mute notifications')),
            PopupMenuItem(value: 'wallpaper', child: Text('Wallpaper')),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
