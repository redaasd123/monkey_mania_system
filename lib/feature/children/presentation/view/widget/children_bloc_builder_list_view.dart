import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';

import '../../manager/cubit/children_cubit.dart';
import '../../manager/cubit/children_state.dart';
import 'children_list_view.dart';

class ChildrenBlocBuilderListView extends StatelessWidget {
  const ChildrenBlocBuilderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChildrenCubit, ChildrenState>(
        listener: (context, state) {
          switch (state.status) {
            // ---------------- Loading ----------------
            case ChildrenStatus.addLoading:
            case ChildrenStatus.updateLoading:
              showLoader(context);
              break;

            // ---------------- Success ----------------
            case ChildrenStatus.addSuccess:
              hideLoader(context);
              showGreenFlush(context, LangKeys.createdSuccessfully);
              break;
            case ChildrenStatus.updateSuccess:
              hideLoader(context);
              showGreenFlush(context, LangKeys.updatedSuccessfully);
              break;
            case ChildrenStatus.success:
              if (Navigator.canPop(context)) hideLoader(context);
              break;

            // ---------------- Failure ----------------
            case ChildrenStatus.failure:
            case ChildrenStatus.addFailure:
            case ChildrenStatus.updateFailure:
              hideLoader(context);
              showRedFlush(context, state.errMessage ?? LangKeys.notFound);
              break;

            // ---------------- Offline ----------------
            case ChildrenStatus.offLineState:
              hideLoader(context);
              showRedFlush(
                context,
                state.errMessage ?? LangKeys.messageFailureOffLine,
              );
              break;

            // ---------------- No Data ----------------
            case ChildrenStatus.empty:
              hideLoader(context);
              break;

            default:
              break;
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ChildrenStatus.searchLoading:
            case ChildrenStatus.addLoading:
            case ChildrenStatus.updateLoading:
              return Stack(
                children: [
                  ChildrenListView(children: state.allChildren),
                  Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue, // غير اللون زي ما تحب
                      size: 60,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
                ],
              );
            case ChildrenStatus.loading:
              return Stack(
                children: [
                  Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 60,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
                ],
              );

            case ChildrenStatus.success:
            case ChildrenStatus.addSuccess:
            case ChildrenStatus.updateSuccess:
              return ChildrenListView(children: state.allChildren);

            case ChildrenStatus.empty:
              return const Center(child: Text(LangKeys.notFound));

            case ChildrenStatus.failure:
            case ChildrenStatus.addFailure:
            case ChildrenStatus.updateFailure:
              return Expanded(
                child: ChildrenListView(children: state.allChildren),
              );

            case ChildrenStatus.offLineState:
              return ChildrenListView(children: state.allChildren);

            default:
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue, // غير اللون زي ما تحب
                  size: 60,
                ),
              );
          }
        },
      ),
    );
  }
}
