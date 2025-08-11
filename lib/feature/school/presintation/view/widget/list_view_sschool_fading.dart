import 'package:flutter/cupertino.dart';
import 'package:monkey_app/core/widget/custom_fading_widget.dart';

import 'detail_school_fading.dart';

class CustomListViewFading extends StatelessWidget {
  const CustomListViewFading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CustomFadingWidget(
            //delay: Duration(milliseconds: index * 100),
            child: DetailSchoolFading(),
          ),
        );
      },
    );
  }
}
