import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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
            appBar: CustomAppBar(title: 'Menue'),
            backgroundColor: const Color(0xC8000000),
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
                            final category = (state.status == LayersStatus.getLayerTowSuccess ||
                                state.status == LayersStatus.cashedLayerTow)
                                ? state.layer2
                                : state.layer1;

                            return Layer1A2GridView(
                              category: category,
                              images: images,
                              state: state,
                            );
                          } else if (state.status == LayersStatus.layer3Success) {
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
                          } else if (state.status == LayersStatus.getLayerOneLoading ||
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const CustomAppBar({super.key, required this.title, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5E6831), // بنفسجي غامق
            Color(0xFF7D609A), // بنفسجي فاتح
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBack)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                )
              else
                const SizedBox(width: 40),

              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.rubikPuddles(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}



//import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
// import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
// import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';
// import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
//
// import '../../../../../../../core/widget/widget/custom_flush.dart';
// import '../../../../../../../core/widget/widget/custom_show_loder.dart';
// import '../../../manager/coffee_bills/order_cubit.dart';
// import 'layer1&2_grid_view.dart';
// import 'layer3_section.dart';
//
// class CreateBillsView extends StatefulWidget {
//   const CreateBillsView({super.key});
//
//   @override
//   State<CreateBillsView> createState() => _CreateBillsViewState();
// }
//
// class _CreateBillsViewState extends State<CreateBillsView> {
//   final billIdController = TextEditingController();
//   final tableNumberController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   int? selectedBillId;
//   bool takeAway = false;
//
//   final List<String> images = const [
//     'assets/image/burgar_photo.jpeg',
//     'assets/image/juice_photo.jpeg',
//     'assets/image/bancaka_photo.jpeg',
//   ];
//
//   @override
//   void dispose() {
//     billIdController.dispose();
//     tableNumberController.dispose();
//     super.dispose();
//   }
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return BlocConsumer<CoffeeBillsCubit, BillsCoffeeState>(
//       listener: (context, state) {
//         if (state.status == CoffeeBillsStatus.createFailure) {
//           hideLoader(context);
//           showRedFlush(context, state.errorMessage ?? "حدث خطأ");
//         } else if (state.status == CoffeeBillsStatus.createLoading) {
//           showLoader(context);
//         } else if (state.status == CoffeeBillsStatus.createSuccess) {
//           hideLoader(context);
//           showGreenFlush(context, 'success');
//           Navigator.of(context).pop();
//         }
//       },
//       builder: (context, state) {
//         if (state.status == CoffeeBillsStatus.createSuccess) {
//           context.read<OrdersCubit>().clearOrders();
//           billIdController.clear();
//           tableNumberController.clear();
//           return CoffeeBillsListView(bills: state.bills);
//         }
//
//         return WillPopScope(
//           onWillPop: () async {
//             final layersCubit = context.read<LayersCubit>();
//
//             if (layersCubit.state.status == LayersStatus.layer3Success) {
//               context.read<LayersCubit>().getLayerOTowCashed();
//               return false; // منع الخروج من الصفحة
//             } else if (layersCubit.state.status == LayersStatus.getLayerTowSuccess ||
//                 layersCubit.state.status == LayersStatus.cashedLayerTow) {
//               context.read<LayersCubit>().getLayerOneCashed();
//               return false;
//             }
//             return true; // لو واقف في Layer1 يسمح بالخروج من الصفحة
//           },
//           child: Scaffold(
//             appBar: CustomAppBar(title: 'Menue'),
//             backgroundColor: const Color(0xC8000000),
//             body: Form(
//               key: _formKey,
//               child: SafeArea(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 10),
//                       BlocBuilder<LayersCubit, LayersState>(
//                         builder: (context, state) {
//                           if (state.status == LayersStatus.getLayerOneSuccess ||
//                               state.status == LayersStatus.cashedLayerOne ||
//                               state.status == LayersStatus.getLayerTowSuccess ||
//                               state.status == LayersStatus.cashedLayerTow) {
//                             final category = (state.status ==
//                                 LayersStatus.getLayerTowSuccess ||
//                                 state.status == LayersStatus.cashedLayerTow)
//                                 ? state.layer2
//                                 : state.layer1;
//
//                             return Layer1A2GridView(
//                               category: category,
//                               images: images,
//                               state: state,
//                             );
//                           } else if (state.status ==
//                               LayersStatus.layer3Success) {
//                             return Layer3Section(
//                               images: images,
//                               colorScheme: colorScheme,
//                               billIdController: billIdController,
//                               tableNumberController: tableNumberController,
//                               selectedBillId: selectedBillId,
//                               takeAway: takeAway,
//                               formKey: _formKey,
//                               onBillIdSelected: (id) {
//                                 setState(() => selectedBillId = id);
//                               },
//                               onTakeAwayChanged: (val) {
//                                 setState(() => takeAway = val);
//                               },
//                             );
//                           } else if (state.status ==
//                               LayersStatus.getLayerOneLoading ||
//                               state.status == LayersStatus.getLayerTowLoading ||
//                               state.status == LayersStatus.layer3Loading) {
//                             return const Center(
//                               child: SpinKitFadingCircle(
//                                 color: Colors.blue,
//                                 size: 60,
//                               ),
//                             );
//                           } else {
//                             return Center(
//                                 child: Text(state.errMessage ?? ''));
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showBack;
//
//   const CustomAppBar({super.key, required this.title, this.showBack = true});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: preferredSize.height,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color(0xFF5E6831), // بنفسجي غامق
//             Color(0xFF7D609A), // بنفسجي فاتح
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(40),
//           bottomRight: Radius.circular(40),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               if (showBack)
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back_ios_new,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                   ),
//                 )
//               else
//                 const SizedBox(width: 40),
//
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     title,
//                     style: GoogleFonts.rubikPuddles(
//                       color: Colors.black,
//                       fontSize: 26,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                 ),
//               ),
//
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.restaurant_menu,
//                   color: Colors.white,
//                   size: 22,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(110);
// }