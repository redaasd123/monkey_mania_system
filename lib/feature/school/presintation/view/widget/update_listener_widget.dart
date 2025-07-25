import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/funcation/show_snack_bar.dart';
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
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          if (Navigator.canPop(context)) Navigator.pop(context);
        }

        if (state is UpdateSuccessState) {
         showSnackBar(context, LangKeys.updatedSuccessfully.tr(),);
         BlocProvider.of<SchoolCubit>(context).fetchSchool();
        }

        if (state is UpdateFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      child: child,
    );
  }
}
