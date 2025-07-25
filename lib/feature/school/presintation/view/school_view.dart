import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/school/data/repos/school_repo_impl.dart';
import 'package:monkey_app/feature/school/domain/use_case/post_school_use_case.dart';
import 'package:monkey_app/feature/school/domain/use_case/fetch_school_use_case.dart';
import 'package:monkey_app/feature/school/presintation/manager/post_cubit/post_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/put_cubit/put_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/post_listener_widget.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/school_view_body.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/update_listener_widget.dart';

import '../../../../core/utils/service_locator.dart';
import '../../domain/use_case/update_school_use_case.dart';

class SchoolView extends StatelessWidget {
  const SchoolView({super.key});

  @override
  Widget build(BuildContext context) {
      return Builder(
        builder: (ctx) => PostListenerWidget(
          child: UpdateListenerWidget(child: Scaffold(body: SchoolViewBody())),
        ),
      );
  }
}

