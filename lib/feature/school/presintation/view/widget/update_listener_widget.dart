import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';
import 'package:monkey_app/feature/school/presintation/manager/put_cubit/put_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';

import '../../../../../core/utils/langs_key.dart';

class UpdateListenerWidget extends StatelessWidget {
  final Widget child;

  const UpdateListenerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateSchoolCubit, UpdateState>(
      listener: (context, state) {
        if (state is UpdateLoadingState) {
          showLoader(context);
        } else {
          if (Navigator.canPop(context)) Navigator.pop(context);
        }

        if (state is UpdateOfflineState) {
          showRedFlush(context, LangKeys.messageFailureOffLine.tr());
        } else if (state is UpdateSuccessState) {
          showGreenFlush(context, LangKeys.updatedSuccessfully.tr());
          BlocProvider.of<SchoolCubit>(context).fetchSchool();
        } else if (state is UpdateFailureState) {
          showRedFlush(context, state.errMessage);
        }
      },
      child: child,
    );
  }
}
