import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/styles.dart';
import 'owner_list_view.dart';

class ChatAppBar extends StatelessWidget {
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
    return diff.inMinutes < 5;
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
      // same day
      return "last seen today at ${DateFormat('HH:mm').format(lastSeen)}";
    } else {
      // different day
      return "last seen on ${DateFormat('MMM d, HH:mm').format(lastSeen)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusText = getLastSeenText();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                CupertinoIcons.back,
                size: 26.sp,
                color: Colors.black,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Profile image + green dot (only if online)
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
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: 12.w),

          // Name + status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                userDataFromChat.name,
                style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                statusText,
                style: TextStyle(
                  color: isOnline ? Colors.green : Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
