import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/funcation/show_snack_bar.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';
import 'package:monkey_app/feature/school/presintation/manager/post_cubit/post_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';

class PostListenerWidget extends StatelessWidget {
  final Widget child;

  const PostListenerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateSchoolCubit, CreateSchoolState>(
      listener: (context, state) {
        if (state is CreateLoadingState) {
         showLoader(context);
        } else {
          // أي حالة غير التحميل نقفل الـ dialog
          if (Navigator.canPop(context)) Navigator.pop(context);

          if (state is CreateOfflineState) {
            showRedFlush(context, LangKeys.messageFailureOffLine.tr());
          } else if (state is CreateSuccessState) {
            showGreenFlush(context, LangKeys.addNote.tr());
            BlocProvider.of<SchoolCubit>(context).fetchSchool();
          } else if (state is CreateFailureState) {
            showRedFlush(context, state.errMessage);
          }
        }
      },
      child: child,
    );
  }
}
