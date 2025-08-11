import 'package:flutter/material.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/show_detail_children_body.dart';

class ShowDetailChildren extends StatelessWidget {
  const ShowDetailChildren({super.key, required this.childrenEntity});

  final ChildrenEntity childrenEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowDetailChildrenBody(childrenEntity: childrenEntity),
    );
  }
}
