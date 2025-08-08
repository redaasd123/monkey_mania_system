import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_bloc_builder_list_view.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_listener_state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CreateChildCubit>()),
        BlocProvider(create: (context) => getIt<UpdateChildrenCubit>()),
      ],
      child:  Scaffold(body: ChildrenListenerState(child: ChildrenViewBody())) ,
    );
  }
}



