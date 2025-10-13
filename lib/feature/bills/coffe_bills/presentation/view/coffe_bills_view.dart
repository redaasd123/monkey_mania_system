import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';

import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../manager/coffee_bills/coffee_bills_cubit.dart';
import '../manager/coffee_bills/order_cubit.dart';
import 'widget/coffe_bills_view_body.dart';

class CoffeeBillsView extends StatelessWidget {
  const CoffeeBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<OrdersCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<CoffeeBillsCubit>()
                ..fetchBillsCoffee(RequestParameters(branch: ['all'])),
        ),
      ],
      child: CoffeeBillsViewBody(),
    );
  }
}
