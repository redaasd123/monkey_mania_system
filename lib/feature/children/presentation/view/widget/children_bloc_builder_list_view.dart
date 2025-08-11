import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_listener_state.dart';

import '../../../../../core/funcation/show_snack_bar.dart';
import '../../manager/cubit/children_cubit.dart';
import 'children_list_view.dart';

class ChildrenBlocBuilderListView extends StatelessWidget {
  const ChildrenBlocBuilderListView({
    super.key,
    required ChildrenListenerState child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChildrenCubit, ChildrenState>(
        builder: (context, state) {
          print("🔥 STATE: ${state.runtimeType}");
          print('🎯 BlocBuilder Rebuilt!');
          if (state is ChildrenSelectedState) {
            return ChildrenListView(children: [state.selectChildren]);
          }
          if (state is ChildrenSuccessState) {
            return ChildrenListView(children: state.children);
          } else if (state is ChildrenFailureState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackBar(context, state.errMessage);
            });
            return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          } else if (state is ChildrenLoadingState) {
            return CircularProgressIndicator();
            // return Skeletonizer(
            //   enabled: true,
            //   child: ListView.builder(
            //     itemCount: 5,
            //     itemBuilder: (context, index) => const DetailSchoolFading(),
            //   ),
            // );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
