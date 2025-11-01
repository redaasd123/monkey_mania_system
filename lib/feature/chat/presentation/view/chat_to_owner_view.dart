import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/chat/presentation/manager/chat_cubit.dart';
import 'package:monkey_app/feature/chat/presentation/view/widget/chat_to_owner_view_body.dart';

class ChatToOwnerView extends StatelessWidget {
  final int id;
  const ChatToOwnerView({super.key, required this.id, });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatCubit>(),
      child: ChatToOwnerViewBody(id: id,),
    );
  }
}
