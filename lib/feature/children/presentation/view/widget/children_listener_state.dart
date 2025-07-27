import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';

import '../../../../../core/funcation/show_snack_bar.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/widget/widget/custom_show_loder.dart';
import '../../manager/cubit/children_cubit.dart';
import '../../manager/cubit/create_child_cubit.dart';
import '../../manager/cubit/update_children_cubit.dart';
import 'children_view_body.dart';

class ChildrenListenerState extends StatelessWidget {
  const ChildrenListenerState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateChildCubit, CreateChildState>(
          listener: (context, state) {
            if (state is CreateChildLoading) {
              showLoader(context); // ✅ عرض اللودر
            } else {
              // ✅ تأكد إن أي حالة غير اللودينج، تقفل اللودر الأول
              if (Navigator.canPop(context)) Navigator.pop(context);

              if (state is CreateChildSuccess) {
                showGreenFlush(context, LangKeys.updatedSuccessfully.tr());
                showGreenFlush(context, LangKeys.createdSuccessfully.tr());
                BlocProvider.of<ChildrenCubit>(context).fetchChildren();
              } else if (state is CreateChildFailure) {
                showRedFlush(context, state.errMessage);
              } else if (state is CreateChildOfflineSaved) {
                showRedFlush(context,LangKeys.messageFailureOffLine.tr());
              }
            }
          },
        ),

        BlocListener<UpdateChildrenCubit, UpdateChildrenState>(
          listener: (context, state) {
            if (state is UpdateSuccessState) {
              if (Navigator.canPop(context))
                Navigator.pop(context); // ✅ Close loader
              showGreenFlush(context,LangKeys.updatedSuccessfully.tr());
              BlocProvider.of<ChildrenCubit>(context).fetchChildren();
            } else if (state is ChildrenOffLineState) {
              showRedFlush(context, LangKeys.messageFailureOffLine.tr());
            } else if (state is UpdateFailureState) {
              if (Navigator.canPop(context))
                Navigator.pop(context); // ✅ Close loader
              showRedFlush(context, state.errMessage);
            } else if (state is UpdateLoadingState) {
              showLoader(context); // ✅ Show loader
            }
          },
        ),
      ],
      child: Scaffold(body: const ChildrenViewBody()),
    );
  }
}
