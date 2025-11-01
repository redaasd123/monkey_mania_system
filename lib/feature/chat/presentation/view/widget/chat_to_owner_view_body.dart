import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/chat_app_bar.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/chat_bubble.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/enter_message_field.dart';

import '../../manager/chat_cubit.dart';

class ChatToOwnerViewBody extends StatefulWidget {
  final int id;
  const ChatToOwnerViewBody({super.key, required this.id});

  @override
  State<ChatToOwnerViewBody> createState() => _ChatToOwnerViewBodyState();
}

class _ChatToOwnerViewBodyState extends State<ChatToOwnerViewBody> {
  late final ChatCubit chatCubit;

  @override
  void initState() {
    super.initState();
    // خزن reference للCubit بدل استخدام context.read() بعد كده
    chatCubit = context.read<ChatCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final role = AuthHelper.getRole();
      if (role == 'admin') {
        // الأونر بيشوف رسائل اليوزر اللي اختاره
        chatCubit.listenToMessages(ownerId: 1, userId: widget.id);
      } else {
        // اليوزر العادي (waiter / reception) بيشوف رسائله مع الأونر
        chatCubit.listenToMessages(ownerId: 1, userId: AuthHelper.getUserId());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ChatAppBar(),
            Divider(height: 12.h, color: Colors.grey[400], thickness: 1),
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state.status == ChatStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage ?? "Error")),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == ChatStatus.loading) {
                    return Center(
                      child: SpinKitSpinningLines(color: colorScheme.primary),
                    );
                  }
                  final messages = state.messages;
                  final userId = AuthHelper.getUserId();
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId == userId;
                      return isMe
                          ? ChatBubble(text: message.messageText)
                          : ChatBubbleForFriend(text: message.messageText);
                    },
                  );
                },
              ),
            ),
            EnterMessageField(
              id: widget.id,
              chatCubit: chatCubit, // مرر الCubit مباشرة
            ),
          ],
        ),
      ),
    );
  }
}
