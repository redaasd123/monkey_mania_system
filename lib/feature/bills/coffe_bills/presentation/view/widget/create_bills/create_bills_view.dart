import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/my_app_drwer.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';

import '../../../../../../../core/utils/constans.dart';
import '../../../../../../../core/widget/widget/custom_flush.dart';
import '../../../../../../../core/widget/widget/custom_show_loder.dart';
import '../../../manager/coffee_bills/order_cubit.dart';
import 'image_scroll_app_bar.dart';
import 'layer1&2_grid_view.dart';
import 'layer3_section.dart';

class CreateBillsView extends StatefulWidget {
  const CreateBillsView({super.key});

  @override
  State<CreateBillsView> createState() => _CreateBillsViewState();
}

class _CreateBillsViewState extends State<CreateBillsView> {
  final billIdController = TextEditingController();
  final tableNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? selectedBillId;
  bool takeAway = false;


  @override
  void dispose() {
    billIdController.dispose();
    tableNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<CoffeeBillsCubit, BillsCoffeeState>(
      listener: (context, state) {
        if (state.status == CoffeeBillsStatus.createFailure) {
          hideLoader(context);
          showRedFlush(context, state.errorMessage ?? "حدث خطأ");
        } else if (state.status == CoffeeBillsStatus.createLoading) {
          showLoader(context);
        } else if (state.status == CoffeeBillsStatus.createSuccess) {
          hideLoader(context);
          showGreenFlush(context, LangKeys.ok.tr());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.status == CoffeeBillsStatus.createSuccess) {
          context.read<OrdersCubit>().clearOrders();
          billIdController.clear();
          tableNumberController.clear();
          return CoffeeBillsListView(bills: state.bills);
        }

        return WillPopScope(
          onWillPop: () async {
            final layersState = context.read<LayersCubit>().state;

            if (layersState.status == LayersStatus.layer3Success) {
              context.read<LayersCubit>().getLayerOTowCashed();
              return false;
            } else if (layersState.status == LayersStatus.getLayerTowSuccess ||
                layersState.status == LayersStatus.cashedLayerTow) {
              context.read<LayersCubit>().getLayerOneCashed();
              return false;
            }
            return true;
          },
          child: Scaffold(
            drawer: MyAppDrawer(),
             appBar: ImageScrollAppBar(
              colorScheme: Theme.of(context).colorScheme,
          images: kProductImages,
        ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            body: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      BlocBuilder<LayersCubit, LayersState>(
                        builder: (context, state) {
                          if (state.status == LayersStatus.getLayerOneSuccess ||
                              state.status == LayersStatus.cashedLayerOne ||
                              state.status == LayersStatus.getLayerTowSuccess ||
                              state.status == LayersStatus.cashedLayerTow) {
                            final category =
                                (state.status ==
                                        LayersStatus.getLayerTowSuccess ||
                                    state.status == LayersStatus.cashedLayerTow)
                                ? state.layer2
                                : state.layer1;

                            return Layer1A2GridView(
                              category: category,
                              images: kProductImages,
                              state: state,
                            );
                          } else if (state.status ==
                              LayersStatus.layer3Success) {
                            return Layer3Section(
                              images: kProductImages,
                              colorScheme: colorScheme,
                              billIdController: billIdController,
                              tableNumberController: tableNumberController,
                              selectedBillId: selectedBillId,
                              takeAway: takeAway,
                              formKey: _formKey,
                              onBillIdSelected: (id) {
                                setState(() => selectedBillId = id);
                              },
                              onTakeAwayChanged: (val) {
                                setState(() => takeAway = val);
                              },
                            );
                          } else if (state.status ==
                                  LayersStatus.getLayerOneLoading ||
                              state.status == LayersStatus.getLayerTowLoading ||
                              state.status == LayersStatus.layer3Loading) {
                            return const Center(
                              child: SpinKitFadingCircle(
                                color: Colors.blue,
                                size: 60,
                              ),
                            );
                          } else {
                            return Center(child: Text(state.errMessage ?? ''));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        ;
      },
    );
  }
}




