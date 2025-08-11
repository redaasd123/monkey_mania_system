import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../../../main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../../../manager/coffee_bills/coffee_bills_cubit.dart';
import '../coffe_bills_view_body.dart';

class AllActiveCoffeeBillsView extends StatelessWidget {
  const AllActiveCoffeeBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          getIt<CoffeeBillsCubit>()
            ..fetchActiveBillsCoffee(FetchBillsParam(branch: ['all'])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          actions: [
            PopupMenuButton<String>(
              icon: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: const Icon(Icons.more_vert, color: Colors.white),
              ),
              onSelected: (value) {
                if (value == 'branch') {
                  showBranchBottomSheet(
                    context,
                    onSelected: (param) {
                      print('📦 All Data: $param');
                      BlocProvider.of<CoffeeBillsCubit>(
                        context,
                      ).fetchActiveBillsCoffee(param);
                      print('❣️❣️❣️❣️❣️');
                    },
                  );
                }
              },

              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'branch',
                  child: Text('Branch'),
                ),
              ],
            ),
          ],
        ),
        body: CoffeeBillsViewBody(),
      ),
    );
  }
}
