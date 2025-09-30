import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/materials.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/manager/material_expense_cubit.dart';

import '../../../../../core/helper/auth_helper.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/utils/selected_item_text_field.dart';
import '../../../../../core/widget/widget/custom_text_field.dart';
import '../../../general_expense/domain/use_case/param/create_param.dart';

class MaterialExpenseBottomSheet extends StatefulWidget {
  const MaterialExpenseBottomSheet({super.key, required this.title, this.item});

  final String title;
  final MaterialExpenseItemEntity? item;

  @override
  State<MaterialExpenseBottomSheet> createState() =>
      _GeneralExpenseBottomSheetState();
}

class _GeneralExpenseBottomSheetState
    extends State<MaterialExpenseBottomSheet> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  int? selectedMaterial;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
       selectedMaterial = widget.item!.id;
      nameCtrl.text = widget.item!.material;
      priceCtrl.text = widget.item!.totalPrice;
      quantityCtrl.text = widget.item?.quantity.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // 👈 يمنع overflow مع الكيبورد
            child: Column(
              mainAxisSize: MainAxisSize.min, // قد المحتوى فقط
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHandle(),
                _buildHeader(colorScheme),
                const SizedBox(height: 20),
                _buildForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectItemTextField<MaterialsEntity>(
              controller: nameCtrl, // نفس الـ controller اللي كنت مستخدمه
              colorScheme: Theme.of(context).colorScheme,
              label: "material", // بدل اسم الـ label
              fetchItems: () async {
                await context.read<MaterialExpenseCubit>().fetchMaterials(FetchBillsParam(branch: ['all']));
                return context.read<MaterialExpenseCubit>().state.materials??[];
              },
              itemTitle: (material) => material.name ?? 'لا يوجد اسم', // طريقة عرض الاسم
              onSelected: (material) {
                selectedMaterial = material.id; // نفس المنطق القديم
                print('Selected school ID: $selectedMaterial');
              },
            ),
            CustomTextField(
              label: ' price',
              hint: 'Enter Total Price',
              controller: priceCtrl,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: ' quantity',
              hint: 'Enter quantity',
              controller: quantityCtrl,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final branch = AuthHelper.getBranch();
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                final param = CreateExpenseParam(
                  branchId: branch,
                  totalPrice: priceCtrl.text,
                  quantity: quantityCtrl.text,
                  materialId: selectedMaterial,
                );

                print(param);
                Navigator.pop(context, param);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.deepPurple,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    'Add',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // ثابتة هنا لأن الجريدينت غامق
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() => Center(
    child: Container(
      width: 48,
      height: 4,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  Widget _buildHeader(ColorScheme colorScheme) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(kTest),
        ),
        const SizedBox(width: 12),
        Text(
          widget.title,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

// class TextFieldMaterialID extends StatefulWidget {
//   const TextFieldMaterialID({
//     super.key,
//     required TextEditingController controler,
//     required this.colorScheme,
//     this.onSelected,
//   }) : _schoolCtrl = controler;
//
//   final TextEditingController _schoolCtrl;
//   final ColorScheme colorScheme;
//   final void Function(int)? onSelected;
//
//   @override
//   State<TextFieldMaterialID> createState() => _TextFieldMaterialIDState();
// }
//
// class _TextFieldMaterialIDState extends State<TextFieldMaterialID> {
//   bool hasFetched = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onTap: () async {
//         final cubit = context.read<MaterialExpenseCubit>();
//         if (!hasFetched) {
//           await cubit.fetchMaterials(FetchBillsParam(branch: ['all']));
//           hasFetched = true;
//         }
//
//         final state = cubit.state;
//         if (state.status == MaterialExpenseStatus.materialsSuccess) {
//           final selectedMaterial = await showModalBottomSheet<MaterialsEntity>(
//             context: context,
//             isScrollControlled: true,
//             backgroundColor: Colors.transparent,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//             ),
//             builder: (_) {
//               return DraggableScrollableSheet(
//                 expand: false,
//                 initialChildSize: 0.7,
//                 minChildSize: 0.4,
//                 maxChildSize: 0.95,
//                 builder: (context, scrollController) {
//                   List<MaterialsEntity> filteredSchools = List.from(
//                     state.materials ?? [],
//                   );
//                   final TextEditingController searchCtrl =
//                       TextEditingController();
//
//                   return StatefulBuilder(
//                     builder: (context, setState) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFF5A55CA),
//                           // gradient: LinearGradient(
//                           //   colors: [Color(0xFF745385), Color(0xFF807387)],
//                           //   begin: Alignment.topCenter,
//                           //   end: Alignment.bottomCenter,
//                           // ),
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(24),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             children: [
//                               // 🔘 Handle
//                               Container(
//                                 width: 50,
//                                 height: 5,
//                                 margin: const EdgeInsets.only(bottom: 16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white54,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//
//                               // 🏫 العنوان
//                               Text(
//                                 "اختر الخامة",
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//
//                               // 🔍 البحث
//                               TextField(
//                                 controller: searchCtrl,
//                                 style: const TextStyle(color: Colors.white),
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   fillColor: Colors.white.withOpacity(0.15),
//                                   hintText: "ابحث الخامة...",
//                                   hintStyle: const TextStyle(
//                                     color: Colors.white70,
//                                   ),
//                                   prefixIcon: const Icon(
//                                     Icons.search,
//                                     color: Colors.white70,
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 onChanged: (query) {
//                                   setState(() {
//                                     filteredSchools = state.materials!
//                                         .where(
//                                           (material) => (material.name ?? '')
//                                               .toLowerCase()
//                                               .contains(query.toLowerCase()),
//                                         )
//                                         .toList();
//                                   });
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//
//                               Expanded(
//                                 child: ListView.builder(
//                                   controller: scrollController,
//                                   itemCount: filteredSchools.length,
//                                   itemBuilder: (context, index) {
//                                     final material = filteredSchools[index];
//
//                                     return Card(
//                                       elevation: 4,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(16),
//                                       ),
//                                       margin: const EdgeInsets.symmetric(
//                                         vertical: 8,
//                                         horizontal: 4,
//                                       ),
//                                       child: ListTile(
//                                         contentPadding: const EdgeInsets.all(
//                                           12,
//                                         ),
//                                         leading: CircleAvatar(
//                                           backgroundColor:
//                                               Colors.indigo.shade400,
//                                           child: const Icon(
//                                             Icons.school,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         title: Text(
//                                           material.name ?? 'لا يوجد اسم',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                         onTap: () => Future.microtask(
//                                           () => Navigator.pop(context, material),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           );
//
//           // ✅ بعد الاختيار
//           if (selectedMaterial != null) {
//             widget._schoolCtrl.text = selectedMaterial.name ?? '';
//             widget.onSelected!(selectedMaterial.id); // ترجع الـ ID
//           }
//         }
//       },
//
//       readOnly: true,
//       validator: (val) {
//         if (val == null) {
//           return LangKeys.nameRequired.tr();
//         }
//       },
//       controller: widget._schoolCtrl,
//       maxLines: 1,
//       style: TextStyle(color: widget.colorScheme.onSurface),
//       decoration: InputDecoration(
//         labelText: 'material',
//         labelStyle: TextStyle(color: widget.colorScheme.onSurface),
//         prefixIcon: Icon(Icons.school, color: widget.colorScheme.onSurface),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: widget.colorScheme.primary, width: 2),
//         ),
//       ),
//     );
//   }
// }
