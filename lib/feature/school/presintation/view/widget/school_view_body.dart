import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/styles.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/school_list_view.dart';

import '../../../../../core/widget/widget/custom_flush.dart';
import '../../../../../core/widget/widget/custom_show_loder.dart';

class SchoolViewBody extends StatefulWidget {
  const SchoolViewBody({super.key});

  @override
  State<SchoolViewBody> createState() => _SchoolViewBodyState();
}

class _SchoolViewBodyState extends State<SchoolViewBody> {
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SchoolCubit, SchoolState>(
      listener: (context, state) {
        /// ----------------------------
        /// 🔹 Loading
        /// ----------------------------

        /// ----------------------------
        /// 🔹 Success
        /// ----------------------------
        if (state.status == SchoolStatus.success) {
          if (Navigator.canPop(context)) hideLoader(context);
        } else if (state.status == SchoolStatus.updateSuccess) {
          if (Navigator.canPop(context)) hideLoader(context);
          showGreenFlush(context, LangKeys.updatedSuccessfully.tr());
        } else if (state.status == SchoolStatus.addSuccess) {
          if (Navigator.canPop(context)) hideLoader(context);
          showGreenFlush(context, LangKeys.addNote.tr());
        }
        /// ----------------------------
        /// 🔹 Failure
        /// ----------------------------
        else if (state.status == SchoolStatus.failure ||
            state.status == SchoolStatus.updateFailure ||
            state.status == SchoolStatus.addFailure) {
          if (Navigator.canPop(context)) hideLoader(context);
          showRedFlush(context, state.errMessage ?? LangKeys.notFound.tr());
        }
        /// ----------------------------
        /// 🔹 Offline
        /// ----------------------------
        else if (state.status == SchoolStatus.offLineState) {
          if (Navigator.canPop(context)) hideLoader(context);
          showRedFlush(context, LangKeys.messageFailureOffLine.tr());
        }
      },
      builder: (context, state) {
        /// 🔹 Show list when data loaded or after add/update
        if (state.status == SchoolStatus.success ||
            state.status == SchoolStatus.addSuccess ||
            state.status == SchoolStatus.updateSuccess) {
          return SchoolListView(school: state.allSchool);
        }
        /// 🔹 Show list with linear progress during create/update
        else if (state.status == SchoolStatus.addLoading ||
            state.status == SchoolStatus.loading ||
            state.status == SchoolStatus.updateLoading) {
          return Stack(
            children: [
              SchoolListView(school: state.allSchool),
              Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue, // غير اللون زي ما تحب
                  size: 60,
                ),
              ),
              const LinearProgressIndicator(minHeight: 3),
            ],
          );
        }
        /// 🔹 Show list while searching
        else if (state.status == SchoolStatus.searchLoading) {
          return Column(
            children: [
              const LinearProgressIndicator(minHeight: 2),
              Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue, // غير اللون زي ما تحب
                  size: 60,
                ),
              ),
              Expanded(child: SchoolListView(school: state.allSchool)),
            ],
          );
        } else if (state.status == SchoolStatus.noResultSearch) {
          return Center(
            child: Text(LangKeys.notFound, style: Styles.textStyle14),
          );
        }
        /// 🔹 Offline or failure
        else if (state.status == SchoolStatus.offLineState ||
            state.status == SchoolStatus.failure ||
            state.status == SchoolStatus.updateFailure ||
            state.status == SchoolStatus.addFailure) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.errMessage ?? LangKeys.notFound.tr(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              Expanded(child: SchoolListView(school: state.allSchool)),
            ],
          );
        }
        /// 🔹 Default loading
        else {
          return const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue, // غير اللون زي ما تحب
              size: 60,
            ),
          );
        }
      },
    );
  }
}
