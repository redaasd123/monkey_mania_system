import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../../users/domain/entity/user_data_entity.dart';
import '../../../../users/presentation/manager/user_cubit.dart';
import '../../manager/chat_cubit.dart';

class OwnerListView extends StatefulWidget {
  const OwnerListView({super.key, required this.users});

  final List<UserDataEntity> users;

  @override
  State<OwnerListView> createState() => _OwnerListViewState();
}

class _OwnerListViewState extends State<OwnerListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _autoFetchMore();
    });
  }

  void _autoFetchMore() {
    if (!mounted) return;

    final cubit = BlocProvider.of<UserCubit>(context);
    final state = cubit.state;

    if (!scrollController.hasClients) return;

    if (scrollController.position.maxScrollExtent <= 0 &&
        state.hasMore &&
        !state.isLoading) {
      cubit.fetchUsers(RequestParameters(page: state.currentPage));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _autoFetchMore();
      });
    }
  }

  void scrollListener() {
    if (!mounted) return;
    final cubit = BlocProvider.of<UserCubit>(context);
    final state = cubit.state;

    if (!scrollController.hasClients) return;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= 0.6 * maxScroll && state.hasMore && !state.isLoading) {
      cubit.fetchUsers(RequestParameters(page: state.currentPage));
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount: widget.users.length,
            itemBuilder: (context, index) {
              // final messages = state.messages;
              final currentUser = widget.users[index];
              final image = images[index % images.length];
              if (currentUser.id > 1) {
                return InkWell(
                  onTap: () {
                    final userData = UserDataFromChat(
                      id: currentUser.id,
                      name: currentUser.name,
                      image: image
                    );

                    GoRouter.of(context).push(
                      AppRouter.kChatWithOwner,
                      extra: userData, // pass the object
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0.w, top: 8),
                    child: Row(
                      children: [
                        // Avatar
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
                        // Name & last message
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.name,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'No messages yet',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),

                        Spacer(),
                        // Last update time & badge
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'justNow',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
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
              }
            },
          ),
        );
      },
    );
  }
}

class UserDataFromChat {
  final String name;
  final int id;
  final String image;
  const UserDataFromChat({required this.image,required this.name, required this.id});
}
