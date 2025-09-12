import 'package:flutter/material.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_bloc_builder_list_view.dart';

class ChildrenViewBody extends StatefulWidget {
  const ChildrenViewBody({super.key});

  @override
  State<ChildrenViewBody> createState() => _ChildrenViewBodyState();
}

class _ChildrenViewBodyState extends State<ChildrenViewBody> {
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChildrenBlocBuilderListView();
  }
}
