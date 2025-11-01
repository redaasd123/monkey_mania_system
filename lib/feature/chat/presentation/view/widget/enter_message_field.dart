import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/auth_helper.dart';
import '../../../domain/entity/chat_entity.dart';
import '../../manager/chat_cubit.dart';

class EnterMessageField extends StatefulWidget {
  const EnterMessageField({
    super.key,
    required this.id,
    required this.chatCubit,
  });

  final int id;
  final ChatCubit chatCubit; // 🌟 reference to Cubit

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
                print(
                  '💬 Sending from user: ${AuthHelper.getUserId()} to receiver: ${widget.id}',
                );
                final role = AuthHelper.getRole();
                final text = _controller.text.trim();
                final userName = AuthHelper.getUsername();
                if (text.isEmpty) return;

                if (role == 'waiter' || role == 'reception') {
                  final userId = AuthHelper.getUserId();
                  final messageEntity = ChatEntity.createFromText(
                    text,
                    userId,
                    1,
                    userName!,
                  );
                  widget.chatCubit.sendMessage(
                    messageEntity,
                  ); // use Cubit reference
                } else if (role == 'admin') {
                  final messageEntity = ChatEntity.createFromText(
                    text,
                    1,
                    widget.id,
                    userName!,
                  );
                  widget.chatCubit.sendMessage(messageEntity);
                }

                _controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
