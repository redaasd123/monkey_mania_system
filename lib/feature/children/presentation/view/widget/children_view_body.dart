import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_bloc_builder_list_view.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_list_view.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/reseve_data_floating_actio_button.dart';

import '../../../../../core/utils/langs_key.dart';

class ChildrenViewBody extends StatefulWidget {
  const ChildrenViewBody({super.key});

  @override
  State<ChildrenViewBody> createState() => _ChildrenViewBodyState();
}

class _ChildrenViewBodyState extends State<ChildrenViewBody> {
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChildrenBlocBuilderListView(),
      floatingActionButton: ReseveDataChildrenActionButton(context),
    );
  }
}
