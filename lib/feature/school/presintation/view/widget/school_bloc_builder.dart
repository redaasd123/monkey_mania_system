import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/list_view_sschool_fading.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/school_list_view.dart';

import '../../manager/school_cubit/school_cubit.dart';

class SchoolListViewBlocBuilder extends StatelessWidget {
  const SchoolListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolCubit, SchoolState>(
      builder: (context, state) {
        if (state is SchoolSelectedState) {
          return SchoolListView(school: [state.selectedSchool]);

        }
        else if (state is SchoolSuccessState) {
          return SchoolListView(school: state.schools);
        } else if (state is SchoolFailureState) {
          return Center(child: Text(state.errMessage));
        } else {
          return CustomListViewFading();
        }
      },
    );

  }
}
