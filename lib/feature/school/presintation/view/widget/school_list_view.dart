import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/school/data/model/school_model.dart';
import 'package:monkey_app/feature/school/presintation/manager/put_cubit/put_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/custom_detail_view.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/show_add_bottom_sheet.dart';

import '../../../domain/entity/school_entity.dart';

class SchoolListView extends StatelessWidget {
  const SchoolListView({super.key, required this.school});

  final List<SchoolEntity> school;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: school.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // 👇 قلبنا الفهرس بحيث 0 ← أحدث عنصر
        final model = school[school.length - 1 - index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: GestureDetector(
            onTap: () async {
        final data = await schoolShowAddSchoolSheet(
        context,
        text: LangKeys.edit.tr(),
          model: model
        );

        final updateCubit = context.read<UpdateSchoolCubit>();

        if (data != null) {
        updateCubit.updateSchool(
        name: data['name']!,
        address: data['address']!,
        notes: (data['notes']?.trim().isEmpty ?? true) ? null : data['notes'],
        id: model.id,
        );

        }
        },

          child: CustomDetailSchoolCard(schoolModel: model),
          ),
        );
      },
    );
  }
}

// final postCubit = context.read<PostCubit>();
//         final data = await showAddSchoolSheet(context);
//         if (data != null) {
//           postCubit.postSchool(
//             name: data['name']!,
//             address: data['address']!,
//             notes: (data['notes']?.trim().isEmpty ?? true)
//                 ? null
//                 : data['notes'],
//           );

//import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:monkey_app/core/utils/app_router.dart';
// import 'package:monkey_app/feature/school/data/model/school_model.dart';
// import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
// import 'package:monkey_app/feature/school/presintation/view/widget/school_list_view_item.dart';
//
// class SchoolListView extends StatelessWidget {
//   const SchoolListView({super.key, required this.school});
//   final List<SchoolModel> school;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: school.length,
//       padding: const EdgeInsets.all(8),
//       itemBuilder: (context, index) {
//         // ➊ قلب الفهرس
//         final model = school[school.length - 1 - index];
//
//         return _SchoolTile(model: model);
//       },
//     );
//   }
// }
//
// class _SchoolTile extends StatelessWidget {
//   const _SchoolTile({required this.model});
//   final SchoolModel model;
//
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: GestureDetector(
//       onTap: () async {
//         final post = PostModel.fromSchoolModel(model);
//         final ok = await GoRouter.of(context)
//             .push(AppRouter.kEditSchool, extra: post);
//         if (ok == true) context.read<SchoolCubit>().fetchSchool();
//       },
//       child: SchoolListViewItem(schoolModel: model),
//     ),
//   );
// }  اشرح بالتفصيل ازاي خليت الايتم اللي احطة اول واحد

//final post = PostModel.fromSchoolModel(model);
//               final ok = await GoRouter.of(
//                 context,
//               ).push(AppRouter.kEditSchool, extra: post);
//               if (ok == true) {
//                 context.read<SchoolCubit>().fetchSchool();
//               }

// class UpdateBlocBuilder extends StatelessWidget {
//   const UpdateBlocBuilder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(builder: (context, state){
//       if(state is PutSuccessState){
//
//       }
//     }
//
//         , listener: (context, state){});
//   }
// }
