import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_view_body_item.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/show_child_bottom_sheet.dart';

import '../../../../../core/param/update_children_param/update_children_param.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../domain/param/fetch_children_param.dart';

class ChildrenListView extends StatefulWidget {
  const ChildrenListView({super.key, required this.children});

  final List<ChildrenEntity> children;

  @override
  State<ChildrenListView> createState() => _ChildrenListViewState();
}

class _ChildrenListViewState extends State<ChildrenListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState(); // ✅ ناسي دي
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    final cubit = BlocProvider.of<ChildrenCubit>(context);
    final state = cubit.state;
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= 0.6 * maxScroll && state.hasMore && !state.isLoading) {
      cubit.fetchChildren(FetchChildrenParam(pageNumber: state.currentPage));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChildrenCubit>(context);
    final children = widget.children;
    final state = cubit.state;
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.fetchChildren(FetchChildrenParam(pageNumber: 1));
      },
      child: ListView.builder(
        controller: scrollController,
        itemCount: children.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= children.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return GestureDetector(
            onTap: () async {
              final data = await showAddChildBottomSheet(
                context,
                LangKeys.edit.tr(),
                model: widget.children[index],
              );
              if (data != null) {
                final updateCubit = BlocProvider.of<ChildrenCubit>(context);
                updateCubit.updateChildren(
                  UpdateChildrenParam(
                    notes: data.notes,
                    school: data.school,
                    phoneNumber: data.phones,
                    name: data.name,
                    address: data.address,
                    id: widget.children[index].id!.toInt(),
                    birthDate: data.birthDate,
                  ),
                );
              }
            },
            child: ChildrenViewBodyItem(childrenEntity: widget.children[index]),
          );
        },
      ),
    );
  }
}









//import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
// import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
// import 'package:monkey_app/feature/children/presentation/view/widget/children_view_body_item.dart';
// import 'package:monkey_app/feature/children/presentation/view/widget/show_child_bottom_sheet.dart';
//
// import '../../../../../core/param/update_children_param/update_children_param.dart';
// import '../../../../../core/utils/langs_key.dart';
// import '../../../domain/param/fetch_children_param.dart';
//
// class ChildrenListView extends StatefulWidget {
//   const ChildrenListView({super.key, required this.children});
//
//   final List<ChildrenEntity> children;
//
//   @override
//   State<ChildrenListView> createState() => _ChildrenListViewState();
// }
//
// class _ChildrenListViewState extends State<ChildrenListView> {
//   late ScrollController scrollController;
//
//   @override
//   void initState() {
//     super.initState(); // ✅ ناسي دي
//     scrollController = ScrollController();
//     scrollController.addListener(scrollListener);
//   }
//
//   void scrollListener() {
//     final cubit = BlocProvider.of<ChildrenCubit>(context);
//
//     if (!scrollController.hasClients) return;
//
//     final maxScroll = scrollController.position.maxScrollExtent;
//     final currentScroll = scrollController.position.pixels;
//
//     if (currentScroll >= 0.6 * maxScroll && cubit.hasMore && !cubit.isLoading) {
//       cubit.fetchChildren(FetchChildrenParam(pageNumber: cubit.currentPage));
//     }
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<ChildrenCubit>(context);
//     final children = widget.children;
//
//     return RefreshIndicator(
//       onRefresh: () async {
//         cubit.currentPage = 1;
//         cubit.hasMore = true;
//         await cubit.fetchChildren(FetchChildrenParam(pageNumber: 1));
//       },
//       child: ListView.builder(
//         controller: scrollController,
//         itemCount: children.length + (cubit.hasMore ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index >= children.length) {
//             return const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//
//           final reversedIndex = children.length - 1 - index;
//           final child = children[reversedIndex];
//
//           return GestureDetector(
//             onTap: () async {
//               final data = await showAddChildBottomSheet(
//                 context,
//                 LangKeys.edit.tr(),
//                 model: child,
//               );
//               if (data != null) {
//                 final updateCubit = BlocProvider.of<ChildrenCubit>(context);
//                 updateCubit.updateChildren(
//                   UpdateChildrenParam(
//                     notes: data.notes,
//                     school: data.school,
//                     phoneNumber: data.phones,
//                     name: data.name,
//                     address: data.address,
//                     id: child.id!.toInt(),
//                     birthDate: data.birthDate,
//                   ),
//                 );
//               }
//             },
//             child: ChildrenViewBodyItem(childrenEntity: child),
//           );
//         },
//       ),
//     );
//   }
// }