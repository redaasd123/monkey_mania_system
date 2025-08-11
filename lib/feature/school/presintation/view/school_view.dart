import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';
import 'package:monkey_app/feature/school/presintation/manager/post_cubit/post_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/put_cubit/put_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/school_view_body.dart';

class SchoolView extends StatelessWidget {
  const SchoolView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SchoolCubit, SchoolState>(
          listener: (context, state) {
            // Handle SchoolCubit state changes
          },
        ),
        BlocListener<CreateSchoolCubit, CreateSchoolState>(
          listener: (context, state) {
            if (state is CreateLoadingState) {
              showLoader(context);
            } else {
              if (Navigator.canPop(context)) Navigator.pop(context);

              if (state is CreateOfflineState) {
                showRedFlush(context, LangKeys.messageFailureOffLine.tr());
              } else if (state is CreateSuccessState) {
                showGreenFlush(context, LangKeys.addNote.tr());
                BlocProvider.of<SchoolCubit>(context).fetchSchool();
              } else if (state is CreateFailureState) {
                showRedFlush(context, state.errMessage);
              }
            }
          },
        ),
        BlocListener<SchoolCubit, SchoolState>(
          listener: (context, state) {
            if (state is SchoolLoadingState) {
              showLoader(context);
            } else if (state is SchoolSuccessState) {
              hideLoader(context);
            } else if (state is SchoolFailureState) {
              showRedFlush(context, state.errMessage);
            }
          },
        ),
        BlocListener<UpdateSchoolCubit, UpdateState>(
          listener: (context, state) {
            if (state is UpdateLoadingState) {
              showLoader(context);
            } else {
              if (Navigator.canPop(context)) Navigator.pop(context);
            }

            if (state is UpdateOfflineState) {
              showRedFlush(context, LangKeys.messageFailureOffLine.tr());
            } else if (state is UpdateSuccessState) {
              showGreenFlush(context, LangKeys.updatedSuccessfully.tr());
              BlocProvider.of<SchoolCubit>(context).fetchSchool();
            } else if (state is UpdateFailureState) {
              showRedFlush(context, state.errMessage);
            }
          },
        ),
      ],
      child: BlocBuilder<SchoolCubit, SchoolState>(
        builder: (context, state) {
          return Scaffold(body: SchoolViewBody());
        },
      ),
    );
  }
}
//Builder(
//       builder: (ctx) => MultiBlocListener(
//         listeners: [
//           /// ✅ Listener لإنشاء المدرسة
//           BlocListener<CreateSchoolCubit, CreateSchoolState>(
//             listener: (context, state) {
//               if (state is CreateLoadingState) {
//                 showLoader(context);
//               } else {
//                 if (Navigator.canPop(context)) Navigator.pop(context);
//
//                 if (state is CreateOfflineState) {
//                   showRedFlush(context, LangKeys.messageFailureOffLine.tr());
//                 } else if (state is CreateSuccessState) {
//                   showGreenFlush(context, LangKeys.addNote.tr());
//                   BlocProvider.of<SchoolCubit>(context).fetchSchool();
//                 } else if (state is CreateFailureState) {
//                   showRedFlush(context, state.errMessage);
//                 }
//               }
//             },
//           ),
//
//           /// ✅ Listener لتحديث المدرسة
//           BlocListener<UpdateSchoolCubit, UpdateState>(
//             listener: (context, state) {
//               if (state is UpdateLoadingState) {
//                 showLoader(context);
//               } else {
//                 if (Navigator.canPop(context)) Navigator.pop(context);
//               }
//
//               if (state is UpdateOfflineState) {
//                 showRedFlush(context, LangKeys.messageFailureOffLine.tr());
//               } else if (state is UpdateSuccessState) {
//                 showGreenFlush(context, LangKeys.updatedSuccessfully.tr());
//                 BlocProvider.of<SchoolCubit>(context).fetchSchool();
//               } else if (state is UpdateFailureState) {
//                 showRedFlush(context, state.errMessage);
//               }
//             },
//           ),
//         ],
//         child: Scaffold(
//           body: SchoolViewBody(), // أو أي Body عندك
//         ),
//       ),
//     );
