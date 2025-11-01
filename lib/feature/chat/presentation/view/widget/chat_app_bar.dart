import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/styles.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(top:12.h),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                CupertinoIcons.back,
                size: 26.sp,
                color: Colors.black,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Profile image with green dot
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Image.asset(
                    'assets/image/reda_img.jpg',
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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

          // Name and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align texts left
            mainAxisAlignment: MainAxisAlignment.start, // Vertically center them in the row
            children: [
              Text(
                'Reda Hassan',
                style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                'Online',
                style: TextStyle(
                  color: Colors.green,
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
