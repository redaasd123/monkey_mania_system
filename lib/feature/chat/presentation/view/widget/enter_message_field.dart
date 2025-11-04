import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/auth_helper.dart';
import '../../../domain/entity/chat_entity.dart';
import '../../manager/chat_cubit.dart';

class EnterMessageField extends StatefulWidget {
  const EnterMessageField({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<EnterMessageField> createState() => _EnterMessageFieldState();
}

class _EnterMessageFieldState extends State<EnterMessageField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          CircleAvatar(
            radius: 22,
            backgroundColor: colorScheme.primary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isEmpty) return;

                  final role = AuthHelper.getRole();
                  final userId = AuthHelper.getUserId();
                  final userName = AuthHelper.getUsername();
                  final receiverId = widget.id;

                  print('💬 Sending from user: $userId to receiver: $receiverId (role: $role)');

                  final chatCubit = context.read<ChatCubit>();

                  ChatEntity messageEntity;

                  if (role == 'waiter' || role == 'reception') {
                    // 👇 Waiter or reception sends message to admin (id = 1)
                    messageEntity = ChatEntity.createFromText(
                      text,
                      userId,
                      1,
                      userName ?? 'Unknown User',
                    );
                  } else if (role == 'admin' || role == 'owner') {
                    // 👇 Admin or owner sends message to user (widget.id)
                    messageEntity = ChatEntity.createFromText(
                      text,
                      1,
                      receiverId,
                      userName ?? 'Admin',
                    );
                  } else {
                    print('⚠️ Unknown role: $role');
                    return;
                  }

                  chatCubit.sendMessage(messageEntity);
                  _controller.clear();
                }

            ),
          ),
        ],
      ),
    );
  }
}
