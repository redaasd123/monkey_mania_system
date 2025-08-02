import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/presentation/manager/bills_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/bills_view_body.dart';

class BillsView extends StatelessWidget {
  const BillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BillsCubit>(),
      child: Scaffold(
        body: BillsViewBody(),
      ),
    );
  }
}
