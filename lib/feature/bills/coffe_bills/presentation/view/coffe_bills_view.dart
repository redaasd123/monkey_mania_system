import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/get_one_bills/get_one_bills_coffee_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../manager/coffee_bills/coffee_bills_cubit.dart';
import 'widget/coffe_bills_view_body.dart';

class CoffeeBillsView extends StatelessWidget {
  const CoffeeBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<CoffeeBillsCubit>()
                ..fetchBillsCoffee(FetchBillsParam(branch: ['all'])),
        ),


      ],
      child: CoffeeBillsViewBody(),
    );
  }
}
