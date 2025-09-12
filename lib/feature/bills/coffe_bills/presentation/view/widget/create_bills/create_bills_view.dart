import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';

import '../../../../../../../core/widget/widget/custom_flush.dart';
import '../../../../../../../core/widget/widget/custom_show_loder.dart';

import '../../../manager/coffee_bills/order_cubit.dart';
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

  final List<String> images = const [
    'assets/image/burgar_photo.jpeg',
    'assets/image/juice_photo.jpeg',
    'assets/image/bancaka_photo.jpeg',
  ];

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
          showGreenFlush(context, 'success');
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

        return Scaffold(
          backgroundColor: Color(0xC8000000),
          body: Form(
            key: _formKey,
            child: Container(
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
                            final category = (state.status ==
                                LayersStatus.getLayerTowSuccess ||
                                state.status == LayersStatus.cashedLayerTow)
                                ? state.layer2
                                : state.layer1;

                            return Layer1A2GridView(
                              category: category,
                              images: images,
                              state: state,
                            );
                          } else if (state.status ==
                              LayersStatus.layer3Success) {
                            return Layer3Section(
                              images: images,
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
                            return Center(
                              child: Text(state.errMessage ?? ''),
                            );
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
      },
    );
  }
}







class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCart;

  const CustomAppBar({super.key, required this.title, this.showCart = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8D8F1), Color(0xFFE8D8F1)], // درجات الأزرق
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
      centerTitle: true,
      actions: [
        if (showCart)
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
