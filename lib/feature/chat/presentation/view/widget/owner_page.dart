import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/feature/users/presentation/manager/user_cubit.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constans.dart';

class OwnerPage extends StatelessWidget {
  const OwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final users = state.data;
        if(state.status==UserStatus.success&&users!=null)
        {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final currentUser = users[index];
                        final image = images[index % images.length];
                        return InkWell(
                          onTap: (){
                            print("📦 currentUser.id = ${currentUser.id}");
                            GoRouter.of(context).push(AppRouter.kChatWithOwner,extra:currentUser.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0.w, top: 8),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius: 28.r,
                                      child: ClipOval(
                                        child: Image.asset(
                                          image,
                                          width: 67.w,
                                          height: 67.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentUser.name,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14.sp, //
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Just Planted a New Sabling today👶...',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        'Just Now',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11.sp, //
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    // if (index == 0)
                                    //   Icon(Icons.done_all, color: Colors.blue),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '8',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }else if(state.status==UserStatus.failure) {
         return Text(state.errorMessage??'');
        }else{
          return Center(child: CircularProgressIndicator());
        }

      },
    );
  }
}
