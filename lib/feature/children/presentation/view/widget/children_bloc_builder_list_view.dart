import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/create_child_cubit.dart';

import '../../../../../core/funcation/show_snack_bar.dart';
import '../../../../school/presintation/view/widget/list_view_sschool_fading.dart';
import '../../manager/cubit/children_cubit.dart';
import 'children_list_view.dart';

class ChildrenBlocBuilderListView extends StatelessWidget {
  const ChildrenBlocBuilderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildrenCubit,ChildrenState>(builder: (context,state){
      if(state is ChildrenSelectedState){
        return ChildrenListView(children:[ state.selectChildren]);
      }
      if(state is ChildrenSuccessState){
        BlocProvider.of<ChildrenCubit>(context).fetchChildren();
        return ChildrenListView(children: state.children);
      }else if(state is ChildrenFailureState){
        return  showSnackBar(context, state.errMessage);
      }else{
        return CustomListViewFading();
        //showLoader(context);
      }
    });
  }
}
