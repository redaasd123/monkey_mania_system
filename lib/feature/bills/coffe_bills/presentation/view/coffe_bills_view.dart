import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../manager/coffee_bills/coffee_bills_cubit.dart';
import 'widget/coffe_bills_view_body.dart';

class CoffeeBillsView extends StatelessWidget {
  const CoffeeBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    final branch = AuthHelper.getBranch();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<CoffeeBillsCubit>()
                ..fetchBillsCoffee(FetchBillsParam(branch: [branch])),
        ),
      ],
      child: CoffeeBillsViewBody(),
    );
  }
}
