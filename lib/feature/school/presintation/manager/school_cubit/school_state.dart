part of 'school_cubit.dart';

@immutable
sealed class SchoolState {}

final class SchoolInitial extends SchoolState {}

final class SchoolLoadingState extends SchoolState {}

final class SchoolFailureState extends SchoolState {
  final String errMessage;

  SchoolFailureState({required this.errMessage});
}

final class SchoolSuccessState extends SchoolState {
  final List<SchoolEntity> schools;

  SchoolSuccessState({required this.schools});
}

class SchoolSelectedState extends SchoolState {
  final SchoolEntity selectedSchool;

  SchoolSelectedState({required this.selectedSchool});
}

class SchoolSearchToggledState extends SchoolState {
  final bool isSearch;

  SchoolSearchToggledState({required this.isSearch});
}
final class SchoolSearchResultState extends SchoolState {}


//import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:monkey_app/core/langs_key.dart';
// import 'package:monkey_app/core/utils/styles.dart';
// import 'package:monkey_app/feature/school/data/model/school_model.dart';
// import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
// import 'package:monkey_app/feature/school/presintation/view/widget/reseve_data_school_action_button.dart';
// import 'package:monkey_app/feature/school/presintation/view/widget/school_bloc_builder.dart';
// import 'package:monkey_app/feature/school/presintation/view/widget/show_add_bottom_sheet.dart';
//
// import '../../manager/post_cubit/post_cubit.dart';
//
// class SchoolViewBody extends StatefulWidget {
//   const SchoolViewBody({super.key});
//
//   @override
//   State<SchoolViewBody> createState() => _SchoolViewBodyState();
// }
//
// class _SchoolViewBodyState extends State<SchoolViewBody> {
//   bool isSearching = false;
//   final searchCtrl = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     return Scaffold(
//       backgroundColor: colorScheme.background, // خلفية التطبيق
//       appBar: AppBar(
//         backgroundColor: colorScheme.primary, // لون الخلفية
//         foregroundColor: colorScheme.onPrimary, // لون النصوص على الخلفية
//         title: isSearching
//             ? TextField(
//                 onChanged: (query) {
//                   BlocProvider.of<SchoolCubit>(context).searchSchools(query);
//                 },
//                 controller: searchCtrl,
//                 decoration: InputDecoration(hintText: 'search'),
//               )
//             : Text('data'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 isSearching = !isSearching;
//               });
//             },
//             icon: Icon(
//               isSearching ? Icons.close : Icons.search,
//               color: colorScheme.onSurface,
//               size: 35,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: isSearching
//                   ? SearchSchoolBuilder()
//                   : const SchoolListViewBlocBuilder(),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: ReseveDataSchoolActionButton(
//         context: context,
//         colorScheme: colorScheme,
//       ),
//     );
//   }
// }
//
// class SearchSchoolBuilder extends StatelessWidget {
//   const SearchSchoolBuilder({super.key,});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SchoolCubit,SchoolState>(
//       builder: (context, state) {
//         if (state is SchoolSuccessState) {
//           final schools = state.schools;
//           return ListView.separated(
//             itemBuilder: (context, index) {
//               final school = schools[index];
//               return ListTile(
//                 onTap: () {
//                    BlocProvider.of<SchoolCubit>(context).selectSchool(school);
//                    final state = context
//                        .findAncestorStateOfType<_SchoolViewBodyState>();
//                    state?.setState(() {
//                      state.isSearching = false;
//                      state.searchCtrl.clear();
//                    });
//                 },
//                 title: Text(school.name),
//               );
//             },
//             separatorBuilder: (_, __) => const Divider(),
//             itemCount: schools.length,
//           );
//         } else if (state is SchoolLoadingState) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is SchoolFailureState) {
//           return Center(child: Text('Error: ${state.errMessage}'));
//         } else {
//           return const SizedBox(); // Default empty
//         }
//       },
//
//     );
//   }
// }
