import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/all_active/all_active_bills_coffee_body.dart';

import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../../../manager/coffee_bills/coffee_bills_cubit.dart';
import '../../../manager/get_one_bills/get_one_bills_coffee_cubit.dart';

class AllActiveCoffeeBillsView extends StatelessWidget {
  const AllActiveCoffeeBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
       BlocProvider(create: (context)=>getIt<GetOneBillsCoffeeCubit>()),
       BlocProvider(
         create: (context) =>
         getIt<CoffeeBillsCubit>()
           ..fetchActiveBillsCoffee(FetchBillsParam(branch: ['all'])),
       ),
     ],

      child: AllActiveBillsCoffeeBody(),
    );
  }
}
