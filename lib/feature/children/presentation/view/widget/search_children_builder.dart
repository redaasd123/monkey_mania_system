// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
//
// class SearchChildrenBuilder extends StatelessWidget {
//   const SearchChildrenBuilder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChildrenCubit, ChildrenState>(
//       builder: (context, state) {
//         if (state is ChildrenSuccessState) {
//           final children = state.children;
//           return ListView.separated(
//             itemBuilder: (context, index) {
//               final selectChild = children[index];
//               return ListTile(
//                 title: Text(selectChild.name!),
//                 onTap: () {
//
//                 },
//               );
//             },
//             separatorBuilder: (_, __) => const Divider(),
//             itemCount: children.length,
//           );
//         } else if (state is ChildrenLoadingState) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is ChildrenFailureState) {
//           return Center(child: Text('Error: ${state.errMessage}'));
//         } else {
//           return const SizedBox(); // Default empty
//         }
//       },
//     );
//   }
// }
