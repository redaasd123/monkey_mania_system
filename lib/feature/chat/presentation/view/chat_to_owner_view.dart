import 'package:flutter/material.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/chat_to_owner_view_body.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/owner_list_view.dart';

class ChatToOwnerView extends StatelessWidget {
  final UserDataFromChat userData;
  const ChatToOwnerView({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return ChatToOwnerViewBody(userDataFromChat: userData,);
  }
}
