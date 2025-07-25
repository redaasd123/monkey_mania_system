import 'package:flutter/material.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/show_detail_children_body.dart';

class ShowDetailChildren extends StatelessWidget {
  const ShowDetailChildren({super.key, required this.childrenModel});
  final ChildrenModel childrenModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowDetailChildrenBody(childrenModel: childrenModel,),
    );
  }}

