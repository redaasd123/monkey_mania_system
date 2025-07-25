import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_view_body.dart';

import '../../../../core/funcation/show_snack_bar.dart';
import '../../../../core/utils/langs_key.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widget/widget/custom_show_loder.dart';
import '../manager/cubit/children_cubit.dart';
import '../manager/cubit/create_child_cubit.dart';
import '../manager/cubit/update_children_cubit.dart';

class ChildrenView extends StatelessWidget {
  const ChildrenView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(
      context,
    ).colorScheme; // Fetch color scheme from theme

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChildrenCubit>()..fetchChildren(),
        ),
        BlocProvider(create: (context) => getIt<CreateChildCubit>()),
        BlocProvider(create: (context) => getIt<UpdateChildrenCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreateChildCubit, CreateChildState>(
              listener: (context, state) {
                if (state is CreateChildSuccess) {
                  showSnackBar(context, LangKeys.createdSuccessfully.tr());
                  BlocProvider.of<ChildrenCubit>(context).fetchChildren();
                } else if (state is CreateChildFailure) {
                  // if (Navigator.canPop(context)) Navigator.pop(context); // ✅ Close loader
                  showSnackBar(context, state.errMessage); // ✅ Show error
                } else if (state is CreateChildOfflineSaved) {
                  showSnackBar(context, state.message); // ✅ Show offline saved message
                } else{
                  showLoader(context); // ✅ Show loader
                }
              }

          ),
          BlocListener<UpdateChildrenCubit, UpdateChildrenState>(
            listener: (context, state) {
              if (state is UpdateSuccessState) {
                if (Navigator.canPop(context))
                  Navigator.pop(context); // ✅ Close loader
                showSnackBar(context, LangKeys.updatedSuccessfully.tr());
                BlocProvider.of<ChildrenCubit>(context).fetchChildren();
              } else if (state is UpdateFailureState) {
                if (Navigator.canPop(context))
                  Navigator.pop(context); // ✅ Close loader
                showSnackBar(context, state.errMessage); // ✅ Show error
              } else if (state is UpdateLoadingState) {
                showLoader(context); // ✅ Show loader
              }
            },
          ),
        ],
        child: Scaffold(body: const ChildrenViewBody()),
      ),
    );
  }
}
