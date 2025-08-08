// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:monkey_app/show_branch_bottom_sheet.dart';
// import 'package:monkey_app/core/theme_color/app_colors.dart';
// import 'package:monkey_app/feature/branch/presentation/manager/branch_cubit.dart';
//
// import '../../../../../core/utils/constans.dart';
// import '../../../../home/presentation/view/widget/view/bottom_sheet/branch_bottom_sheet_body.dart';
//
// class CustomAppBar extends StatelessWidget {
//   const CustomAppBar({super.key, required this.onPressed});
//
//   final Function() onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     final colorTheme = Theme.of(context).colorScheme;
//     return Container(
//       width: double.infinity,
//       height: 66.0,
//       decoration: const BoxDecoration(color: AppColors.lightPrimary),
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: onPressed,
//             icon: Padding(
//               padding: const EdgeInsets.only(top: 18.0),
//               child: const Icon(Icons.menu, color: Colors.white),
//             ),
//           ),
//           const Spacer(),
//
//           PopupMenuButton<String>(
//             icon: Padding(
//               padding: const EdgeInsets.only(top: 18.0),
//               child: const Icon(Icons.more_vert, color: Colors.white),
//             ),
//             onSelected: (value) {
//               if (value == 'branch') {
//                 showBranchBottomSheet(context);
//               } else if (value == 'date') {
//                 showBranchBottomSheet(context);
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem<String>(
//                 value: 'branch',
//                 child: Text('Branch'),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'date',
//                 child: Text('DateBiker'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
