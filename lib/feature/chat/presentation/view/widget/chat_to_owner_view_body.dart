import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/chat_app_bar.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/chat_bubble.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/enter_message_field.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/owner_list_view.dart';

import '../../manager/chat_cubit.dart';

class ChatToOwnerViewBody extends StatefulWidget {
  final UserDataFromChat userDataFromChat;
  const ChatToOwnerViewBody({super.key, required this.userDataFromChat});

  @override
  State<ChatToOwnerViewBody> createState() => _ChatToOwnerViewBodyState();
}

class _ChatToOwnerViewBodyState extends State<ChatToOwnerViewBody> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final chatCubit = context.read<ChatCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final role = AuthHelper.getRole();
      if (role == 'admin') {
        chatCubit.listenToMessages(ownerId: 1, userId: widget.userDataFromChat.id);
      } else {
        chatCubit.listenToMessages(ownerId: 1, userId: AuthHelper.getUserId());
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state.status == ChatStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
        }

        if (state.status == ChatStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }
      },

        builder: (context, state) {
          final messages = state.messages;
          final userId = AuthHelper.getUserId();
          final chatUserId = widget.userDataFromChat.id;

          final userMessages = messages.where((msg) =>
          msg.senderId == chatUserId || msg.receiverId == chatUserId
          ).toList();

          final lastUpdated = userMessages.isNotEmpty ? userMessages.last.lastUpdate : null;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  ChatAppBar(
                    userDataFromChat: widget.userDataFromChat,
                    lastUpdate: lastUpdated,
                  ),
                  Divider(height: 12.h, color: Colors.grey[400], thickness: 1),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      itemCount: messages.length,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.senderId == userId;
                        return isMe
                            ? ChatBubble(data: message)
                            : ChatBubbleForFriend(data: message);
                      },
                    ),
                  ),
                  EnterMessageField(id: widget.userDataFromChat.id),
                ],
              ),
            ),
          );
        }
    );
  }

}
