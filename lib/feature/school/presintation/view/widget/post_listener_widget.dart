import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/funcation/show_snack_bar.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/school/presintation/manager/post_cubit/post_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';

class PostListenerWidget extends StatelessWidget {
  final Widget child;

  const PostListenerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostCubit, PostState>(
      listener: (context, state) {
        if (state is PostLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          if (Navigator.canPop(context)) Navigator.pop(context);
        }

        if (state is PostSuccessState) {
         showSnackBar(context, LangKeys.addNote.tr());
         BlocProvider.of<SchoolCubit>(context).fetchSchool();
        }

        if (state is PostFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(LangKeys.alreadyExsists.tr())),
          );
        }
      },
      child: child,
    );
  }
}