import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import '../manager/coffee_bills/coffee_bills_cubit.dart';
import 'widget/coffe_bills_view_body.dart';

class CoffeeBillsView extends StatelessWidget {
  const CoffeeBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return

      Scaffold( appBar: AppBar(
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
                    BlocProvider.of<CoffeeBillsCubit>(context).fetchBillsCoffee(param);

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
      ), body: CoffeeBillsViewBody());

  }
}
