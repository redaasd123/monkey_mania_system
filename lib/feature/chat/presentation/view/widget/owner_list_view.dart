import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:monkey_app/feature/users/presentation/manager/user_cubit.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../../users/domain/entity/user_data_entity.dart';
import '../../manager/chat_cubit.dart';

class OwnerListViewBlocConsumer extends StatefulWidget {
  const OwnerListViewBlocConsumer({super.key, required this.users});

  final List<UserDataEntity> users;

  @override
  State<OwnerListViewBlocConsumer> createState() =>
      _OwnerListViewBlocConsumerState();
}

class _OwnerListViewBlocConsumerState extends State<OwnerListViewBlocConsumer> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoFetchMore());
  }

  void _autoFetchMore() {
    if (!mounted) return;
    final cubit = BlocProvider.of<UserCubit>(context);
    final state = cubit.state;
    if (scrollController.position.maxScrollExtent <= 0 &&
        state.hasMore &&
        !state.isLoading) {
      cubit.fetchUsers(RequestParameters(page: state.currentPage));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _autoFetchMore();
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
    const int currentOwnerId = 1;

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final messages = state.messages;
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () => BlocProvider.of<UserCubit>(
              context,
            ).fetchUsers(RequestParameters(branch: ['all'])),
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.zero,
              itemCount: widget.users.length,
              itemBuilder: (context, index) {
                final currentUser = widget.users[index];
                if (currentUser.id <= 1) return const SizedBox.shrink();

                final image = images[index % images.length];

                // Filter messages only between owner and this user
                final chatMessages = messages
                    .where(
                      (m) =>
                          (m.senderId == currentOwnerId &&
                              m.receiverId == currentUser.id) ||
                          (m.senderId == currentUser.id &&
                              m.receiverId == currentOwnerId),
                    )
                    .toList();

                // Last message
                final lastMessage = chatMessages.isNotEmpty
                    ? chatMessages.last
                    : null;

                final messageText =
                    lastMessage?.messageText ?? "No messages yet";
                final lastSeen =
                    lastMessage?.lastSeenFormatted ?? "Offline recently";

                // Unread count (messages sent TO owner and not seen)
                final unreadCount = chatMessages
                    .where(
                      (m) => m.receiverId == currentOwnerId && !m.seenMessage,
                    )
                    .length;

                return ChatListViewItem(
                  currentUser: currentUser,
                  image: image,
                  lastMessage: lastMessage,
                  messageText: messageText,
                  lastSeen: lastSeen,
                  unreadCount: unreadCount,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ChatListViewItem extends StatelessWidget {
  const ChatListViewItem({
    super.key,
    required this.currentUser,
    required this.image,
    required this.lastMessage,
    required this.messageText,
    required this.lastSeen,
    required this.unreadCount,
  });

  final UserDataEntity currentUser;
  final String image;
  final ChatEntity? lastMessage;
  final String messageText;
  final String lastSeen;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final userData = UserDataFromChat(
          id: currentUser.id,
          name: currentUser.name,
          image: image,
        );
        GoRouter.of(context).push(AppRouter.kChatWithOwner, extra: userData);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            // Avatar with online/offline ring
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lastMessage?.isOnline == true
                    ? Colors.green
                    : Colors.grey,
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

            SizedBox(width: 12.w),

            // Name + last message
            Expanded(
              child: Column(
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
                    messageText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // Time + unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lastSeen,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                if (unreadCount > 0)
                  Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(color: Colors.white),
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
}

/// Helper class for navigation
class UserDataFromChat {
  final String name;
  final int id;
  final String image;

  const UserDataFromChat({
    required this.image,
    required this.name,
    required this.id,
  });
}
