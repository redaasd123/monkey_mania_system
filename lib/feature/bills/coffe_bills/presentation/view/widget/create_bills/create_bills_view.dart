import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/widget/widget/custom_text_field.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/layers_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../../../core/utils/constans.dart';
import '../../../../../../../core/utils/langs_key.dart';

class CreateBillsView extends StatefulWidget {
  const CreateBillsView({super.key});

  @override
  State<CreateBillsView> createState() => _CreateBillsViewState();
}

class _CreateBillsViewState extends State<CreateBillsView> {
  final billsCtrl = TextEditingController();
  final tableCtrl = TextEditingController();
  int? selectBillsId;
  bool takeAway = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFieldBillsID(
                billsCtrl: billsCtrl,
                colorScheme: colorScheme,
                onSelected: (int id) {
                  selectBillsId = id;
                },
              ),
              CustomTextField(
                label: 'table',
                hint: 'Enter Table Number',
                controller: tableCtrl,
                keyboardType: TextInputType.phone,
              ),
              SwitchListTile(
                value: takeAway,
                onChanged: (val) {
                  setState(() {
                    takeAway = val;
                  });
                },
              ),

              BlocBuilder<LayersCubit, LayersState>(
                builder: (context, state) {
                  // ---------------- Layer 1 & Layer 2 ----------------
                  if (state.status == LayersStatus.getLayerOneSuccess ||
                      state.status == LayersStatus.cashedLayerOne ||
                      state.status == LayersStatus.getLayerTowSuccess ||
                      state.status == LayersStatus.cashedLayerTow) {
                    final category =
                        (state.status == LayersStatus.getLayerTowSuccess ||
                            state.status == LayersStatus.cashedLayerTow)
                        ? state.layer2
                        : state.layer1;

                    return Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            final item = category[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  if (state.status ==
                                      LayersStatus.getLayerOneSuccess) {
                                    // 🔹 الضغط على Layer 1 → استدعاء Layer 2
                                    context.read<LayersCubit>().getLayerTow(
                                      FetchBillsParam(
                                        layer1: item.name,
                                        branch: [1],
                                      ),
                                    );
                                  } else if (state.status ==
                                          LayersStatus.getLayerTowSuccess ||
                                      state.status ==
                                          LayersStatus.cashedLayerTow) {
                                    // 🔹 الضغط على Layer 2 → استدعاء Layer 3
                                    context.read<LayersCubit>().getAllLayer(
                                      FetchBillsParam(
                                        layer1: state.selectedLayer1,
                                        layer2: item.name,
                                        branch: [1],
                                      ),
                                    );
                                  }
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(16),
                                            ),
                                        child: Image.asset(
                                          kTest,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.name,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        if (state.status == LayersStatus.getLayerTowSuccess ||
                            state.status == LayersStatus.cashedLayerTow)
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<LayersCubit>().getLayerOneCashed();
                              },
                              child: const Text('Back to Layer 1'),
                            ),
                          ),
                      ],
                    );
                  }
                  // ---------------- Layer 3 ----------------
                  else if (state.status == LayersStatus.layer3Success) {
                    return Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                          itemCount: state.layer3.length,
                          itemBuilder: (context, index) {
                            final item = state.layer3[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(16),
                                            ),
                                        child: Image.asset(
                                          kTest,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.product ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<LayersCubit>().getLayerOTowCashed();
                            },
                            child: const Text('Back to Layer 2'),
                          ),
                        ),
                      ],
                    );
                  }
                  // ---------------- Loading ----------------
                  else if (state.status == LayersStatus.getLayerOneLoading ||
                      state.status == LayersStatus.getLayerTowLoading ||
                      state.status == LayersStatus.layer3Loading) {
                    return const Center(
                      child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                    );
                  }
                  // ---------------- Error ----------------
                  else {
                    return Center(child: Text(state.errMessage ?? ''));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldBillsID extends StatefulWidget {
  const TextFieldBillsID({
    super.key,
    required TextEditingController billsCtrl,
    required this.colorScheme,
    this.onSelected,
  }) : _billsCtrl = billsCtrl;

  final TextEditingController _billsCtrl;
  final ColorScheme colorScheme;
  final void Function(int)? onSelected;

  @override
  State<TextFieldBillsID> createState() => _TextFieldBillsIDState();
}

class _TextFieldBillsIDState extends State<TextFieldBillsID> {
  bool hasFetched = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        final cubit = BlocProvider.of<BillsCubit>(context);

        if (!hasFetched) {
          // ✅ افتح اللودر
          showDialog(
            context: context,
            barrierDismissible: false, // ممنوع يتقفل إلا بالكود
            builder: (_) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue, // غير اللون زي ما تحب
                  size: 60,
                ),
              );
            },
          );

          await cubit.fetchActiveBills(FetchBillsParam(branch: ['all']));
          hasFetched = true;

          // ✅ اقفل اللودر بعد التحميل
          Navigator.of(context, rootNavigator: true).pop();
        }

        final state = cubit.state;
        if (state.status == BillsStatus.activeSuccess) {
          final selectedBills = await showModalBottomSheet<BillsEntity>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  List<BillsEntity> filteredSchools = List.from(state.bills);
                  final TextEditingController searchCtrl =
                      TextEditingController();

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // 🔍 البحث
                            TextField(
                              controller: searchCtrl,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: LangKeys.search.tr(),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (query) {
                                setState(() {
                                  filteredSchools = state.bills
                                      .where(
                                        (bills) =>
                                            (bills.children?[0].name ?? '')
                                                .toLowerCase()
                                                .contains(query.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            // 📋 القائمة
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                itemCount: filteredSchools.length,
                                itemBuilder: (context, index) {
                                  final school = filteredSchools[index];
                                  return ListTile(
                                    title: Text(
                                      school.children?[0].name ?? 'لا يوجد اسم',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    leading: Icon(
                                      Icons.school,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    onTap: () => Future.microtask(
                                      () => Navigator.pop(context, school),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
          // selectedBills.children?[1].name ??
          // ✅ بعد الاختيار
          if (selectedBills != null) {
            widget._billsCtrl.text = selectedBills.children?[0].name ?? '';
            widget.onSelected!(selectedBills.id);
          }
        }
      },
      readOnly: true,
      validator: (val) {
        if (val == null) {
          return LangKeys.nameRequired.tr();
        }
      },
      controller: widget._billsCtrl,
      maxLines: 1,
      style: TextStyle(color: widget.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: LangKeys.bills.tr(),
        labelStyle: TextStyle(color: widget.colorScheme.onSurface),
        prefixIcon: Icon(Icons.school, color: widget.colorScheme.onSurface),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}
