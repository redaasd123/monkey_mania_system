import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/widget/widget/custom_text_field.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/param/create_bills_coffee_param.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/order_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/create_bills/item_layer1A2.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/widget/widget/custom_flush.dart';
import '../../../../../../../core/widget/widget/custom_show_loder.dart';
import 'card_layer3.dart';
import 'field_bills_id.dart';

class CreateBillsView extends StatefulWidget {
  const CreateBillsView({super.key});

  @override
  State<CreateBillsView> createState() => _CreateBillsViewState();
}

class _CreateBillsViewState extends State<CreateBillsView> {
  final billsCtrl = TextEditingController();
  final tableCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? selectBillsId;
  bool takeAway = false;
  final List<String> images = [
    'assets/image/burgar_photo.jpeg',
    'assets/image/juice_photo.jpeg',
    'assets/image/bancaka_photo.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<CoffeeBillsCubit, BillsCoffeeState>(
      listener: (context, state) async {
        // ---------------- Failure ----------------
        if (state.status == CoffeeBillsStatus.createFailure) {
          hideLoader(context);
          showRedFlush(context, state.errorMessage ?? "حدث خطأ");
        }
        if (state.status == CoffeeBillsStatus.createLoading) {
          showLoader(context);
        }
        if (state.status == CoffeeBillsStatus.createSuccess) {
          hideLoader(context);
          showGreenFlush(context, 'succees');
          Navigator.of(context).pop();
        }

        // ---------------- Loading ----------------
      },
      builder: (context, state) {
        if (state.status == CoffeeBillsStatus.createSuccess) {
          billsCtrl.clear();
          tableCtrl.clear();
          return CoffeeBillsListView(bills: state.bills);
        } else {
          return Scaffold(
            backgroundColor: Colors.blueGrey,
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // ✅ عرض الطبقات
                        BlocBuilder<LayersCubit, LayersState>(
                          builder: (context, state) {
                            // ---------------- Layer 1 & 2 ----------------
                            if (state.status ==
                                    LayersStatus.getLayerOneSuccess ||
                                state.status == LayersStatus.cashedLayerOne ||
                                state.status ==
                                    LayersStatus.getLayerTowSuccess ||
                                state.status == LayersStatus.cashedLayerTow) {
                              final category =
                                  (state.status ==
                                          LayersStatus.getLayerTowSuccess ||
                                      state.status ==
                                          LayersStatus.cashedLayerTow)
                                  ? state.layer2
                                  : state.layer1;

                              return Column(
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(12),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              3, // تلاتة كروت في الصف
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 0.8,
                                        ),
                                    itemCount: category.length,
                                    itemBuilder: (context, index) {
                                      final item = category[index];
                                      final imagePath =
                                          images[index % images.length];
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        elevation: 4,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          onTap: () {
                                            if (state.status ==
                                                    LayersStatus
                                                        .getLayerOneSuccess ||
                                                state.status ==
                                                    LayersStatus
                                                        .cashedLayerOne) {
                                              context
                                                  .read<LayersCubit>()
                                                  .getLayerTow(
                                                    FetchBillsParam(
                                                      layer1: item.name,
                                                      branch: [1],
                                                    ),
                                                  );
                                            } else {
                                              context
                                                  .read<LayersCubit>()
                                                  .getAllLayer(
                                                    FetchBillsParam(
                                                      layer1:
                                                          state.selectedLayer1,
                                                      layer2: item.name,
                                                      branch: [1],
                                                    ),
                                                  );
                                            }
                                          },
                                          child: ItemLayer1A2(
                                            imagePath: imagePath,
                                            item: item,
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  // زر الرجوع من Layer 2 → Layer 1
                                  if (state.status ==
                                          LayersStatus.getLayerTowSuccess ||
                                      state.status ==
                                          LayersStatus.cashedLayerTow)
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          context
                                              .read<LayersCubit>()
                                              .getLayerOneCashed();
                                        },
                                        icon: const Icon(Icons.arrow_back),
                                        label: const Text("الرجوع إلى Layer 1"),
                                      ),
                                    ),
                                ],
                              );
                            }
                            // ---------------- Layer 3 ----------------
                            else if (state.status ==
                                LayersStatus.layer3Success) {
                              return Column(
                                children: [
                                  BlocBuilder<OrdersCubit, List<OrderItem>>(
                                    builder: (context, state) {
                                      if (state.isEmpty) {
                                        return const SizedBox.shrink();
                                      }
                                      return SizedBox(
                                        height: 220, // ارتفاع متوسط للكارت
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.length,
                                          itemBuilder: (context, index) {
                                            final order = state[index];

                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                                    ),
                                                    builder: (context) {
                                                      return OrderBottomSheet(
                                                        initialNotes: order.notes,
                                                        initialQuantity: order.quantity,
                                                        item: order.product,
                                                        imagePath: order.imagePath,
                                                        onAdd: (quantity, notes, selectedItem, imagePath) {
                                                          context.read<OrdersCubit>().updateOrder(
                                                            index,
                                                            OrderItem(
                                                              product: selectedItem,
                                                              quantity: quantity,
                                                              notes: notes,
                                                              imagePath: imagePath,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 140, // عرض الكارت
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [Colors.orange.shade100, Colors.orange.shade300],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    ),
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.15),
                                                        blurRadius: 6,
                                                        offset: const Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        // الصورة دائرية
                                                        CircleAvatar(
                                                          radius: 35,
                                                          backgroundImage: AssetImage(order.imagePath),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        // اسم المنتج
                                                        Text(
                                                          order.product.product ?? '',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        const SizedBox(height: 4),
                                                        // السعر والكمية
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            const Icon(Icons.attach_money, size: 14, color: Colors.green),
                                                            const SizedBox(width: 2),
                                                            Text(
                                                              "${order.product.price ?? 0}",
                                                              style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.green,
                                                              ),
                                                            ),
                                                            const SizedBox(width: 8),
                                                            const Icon(Icons.confirmation_num, size: 14, color: Colors.grey),
                                                            const SizedBox(width: 2),
                                                            Text(
                                                              "x${order.quantity}",
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 4),
                                                        // الملاحظات
                                                        if ((order.notes ?? '').isNotEmpty)
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                            decoration: BoxDecoration(
                                                              color: Colors.white70,
                                                              borderRadius: BorderRadius.circular(12),
                                                            ),
                                                            child: Text(
                                                              order.notes!,
                                                              style: const TextStyle(
                                                                fontSize: 11,
                                                                color: Colors.orange,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        const Spacer(),
                                                        // زر الحذف
                                                        Align(
                                                          alignment: Alignment.bottomRight,
                                                          child: CircleAvatar(
                                                            radius: 14,
                                                            backgroundColor: Colors.redAccent,
                                                            child: IconButton(
                                                              padding: EdgeInsets.zero,
                                                              icon: const Icon(Icons.close, size: 16, color: Colors.white),
                                                              onPressed: () {
                                                                context.read<OrdersCubit>().removeOrder(index);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );




                                    },
                                  ),

                                  BlocBuilder<OrdersCubit, List<OrderItem>>(
                                    builder: (context, state) {
                                      if (state.isNotEmpty) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                // 🏷 Bills ID
                                                Expanded(
                                                  flex: 3, // نسبة المساحة
                                                  child: TextFieldBillsID(
                                                    billsCtrl: billsCtrl,
                                                    colorScheme: colorScheme,
                                                    onSelected: (int id) {
                                                      selectBillsId = id;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                // 🏷 Table Number
                                                Expanded(
                                                  flex: 2, // أقل مساحة من البيلز
                                                  child: CustomTextField(
                                                    label: 'table',
                                                    hint: 'Enter Table Number',
                                                    controller: tableCtrl,
                                                    keyboardType: TextInputType.phone,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                // 🏷 Take Away Switch
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Take Away',
                                                        style: TextStyle(fontSize: 14),
                                                      ),
                                                      Switch(
                                                        value: takeAway,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            takeAway = val;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            // 🏷 زر الإرسال
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (!_formKey.currentState!.validate()) return;
                                                  if (selectBillsId == null) {
                                                    showRedFlush(context, LangKeys.nameRequired.tr());
                                                    return;
                                                  }

                                                  final state = context.read<OrdersCubit>().state;

                                                  final products = state.map((order) {
                                                    return Products(
                                                      productType: "product",
                                                      productId: order.product.id ?? 0,
                                                      quantity: order.quantity,
                                                      notes: order.notes,
                                                    );
                                                  }).toList();

                                                  final param = CreateBillsPCoffeeParam(
                                                    product: products,
                                                    billId: selectBillsId ?? 0,
                                                    tableNumber: int.tryParse(tableCtrl.text.trim()) ?? 1,
                                                    takeAway: takeAway,
                                                  );

                                                  print(param);

                                                  BlocProvider.of<CoffeeBillsCubit>(context)
                                                      .createBillsCoffeeCubit(param);
                                                  context.read<OrdersCubit>().clearOrders();
                                                },
                                                child: const Text("Send Data"),
                                              ),
                                            ),
                                          ],
                                        );

                                      } else {
                                        return SizedBox();
                                      }
                                    },
                                  ),

                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(12),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 0.75,
                                        ),
                                    itemCount: state.layer3.length,
                                    itemBuilder: (context, index) {
                                      final item = state.layer3[index];
                                      final imagePath =
                                          images[index % images.length];
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(24),
                                                  ),
                                            ),
                                            builder: (context) {
                                              return OrderBottomSheet(
                                                item: item,
                                                imagePath: imagePath,
                                                onAdd:
                                                    (
                                                      quantity,
                                                      notes,
                                                      selectedItem,
                                                      imagePath,
                                                    ) {
                                                      context
                                                          .read<OrdersCubit>()
                                                          .addOrder(
                                                            OrderItem(
                                                              product:
                                                                  selectedItem,
                                                              quantity:
                                                                  quantity,
                                                              notes: notes,
                                                              imagePath:
                                                                  imagePath,
                                                            ),
                                                          );
                                                    },
                                              );
                                            },
                                          );
                                        },
                                        child: CardLayer3Widget(
                                          imagePath: imagePath,
                                          item: item,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      context
                                          .read<LayersCubit>()
                                          .getLayerOTowCashed();
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                    label: const Text("الرجوع إلى Layer 2"),
                                  ),
                                ],
                              );
                            }
                            // ---------------- Loading ----------------
                            else if (state.status ==
                                    LayersStatus.getLayerOneLoading ||
                                state.status ==
                                    LayersStatus.getLayerTowLoading ||
                                state.status == LayersStatus.layer3Loading) {
                              return const Center(
                                child: SpinKitFadingCircle(
                                  color: Colors.blue,
                                  size: 60,
                                ),
                              );
                            }
                            // ---------------- Error ----------------
                            else {
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
        }
      },
    );
  }
}

class OrderBottomSheet extends StatefulWidget {
  final GetAllLayerEntity item;
  final String imagePath;
  final void Function(
    int quantity,
    String notes,
    GetAllLayerEntity item,
    String imagePath,
  )
  onAdd;

  final int? initialQuantity;
  final String? initialNotes;

  const OrderBottomSheet({
    super.key,
    required this.item,
    required this.imagePath,
    required this.onAdd,
    this.initialQuantity,
    this.initialNotes,
  });

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  late int counter;
  late TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    counter = widget.initialQuantity ?? 1;
    notesController.text = widget.initialNotes ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade900, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- صورة المنتج دائرية مع ظل ---
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.deepPurple.shade700,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        widget.imagePath,
                        height: 110,
                        width: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- السعر والكمية المتاحة ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.price_check, color: Colors.greenAccent, size: 22),
                        const SizedBox(width: 4),
                        Text(
                          "${widget.item.price ?? 0} ج.م",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.inventory_2, color: Colors.orangeAccent, size: 22),
                        const SizedBox(width: 4),
                        Text(
                          "المتاح: ${widget.item.availableUnits}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- اختيار الكمية ---
                Text(
                  'الكمية',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => setState(() => counter++),
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.greenAccent,
                        size: 36,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$counter',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (counter > 0) counter--;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                        size: 36,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- ملاحظات ---
                TextField(
                  controller: notesController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "ملاحظات إضافية",
                    labelStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade800,
                    prefixIcon: const Icon(Icons.note_alt, color: Colors.lightBlueAccent),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // --- الأزرار Gradient ---
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.deepOrange.shade600],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.amberAccent, Colors.purple],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            if (counter >= 1) {
                              widget.onAdd(
                                counter,
                                notesController.text,
                                widget.item,
                                widget.imagePath,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            widget.initialQuantity == null
                                ? 'إضافة الطلب'
                                : 'تعديل الطلب ',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );



  }
}
