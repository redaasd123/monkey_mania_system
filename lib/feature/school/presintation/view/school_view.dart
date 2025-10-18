import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/poppup_menu_button.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/reseve_data_school_action_button.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/school_view_body.dart';

import '../../../../core/download_fiels/download_file.dart';
import '../../../../core/secret/secret.dart';
import '../../../../core/utils/constans.dart';
import '../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';

class SchoolView extends StatefulWidget {
  const SchoolView({super.key});

  @override
  State<SchoolView> createState() => _SchoolViewState();
}

class _SchoolViewState extends State<SchoolView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<SchoolCubit, SchoolState>(
          builder: (context, state) {
            return state.isSearching
                ? TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    cursorColor: colorScheme.onPrimary,
                    decoration: InputDecoration(
                      hintText: LangKeys.school.tr(),
                      hintStyle: TextStyle(
                        color: colorScheme.onPrimary.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      filled: true,
                      fillColor: colorScheme.primary,
                    ),
                    onChanged: (val) {
                      final cubit = context.read<SchoolCubit>();
                      if (val.trim().isEmpty) {
                        cubit.fetchSchool();
                      } else if (val.length >= 2) {
                        cubit.searchSchool(val);
                      }
                    },
                  )
                : Text(
                    LangKeys.school.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
          },
        ),
        actions: [
          IconButton(
            icon: BlocBuilder<SchoolCubit, SchoolState>(
              builder: (context, state) {
                return Icon(state.isSearching ? Icons.close : Icons.search);
              },
            ),
            onPressed: () {
              setState(() {
                context.read<SchoolCubit>().toggleSearch();
              });
            },
          ),
          CustomPopupMenu(
            onDownload: () async {
              final cubit = context.read<BillsCubit>().state;
              await requestStoragePermission();
                  final downloader = FileDownloaderUI();
                  final RequestParameters param = RequestParameters(
                    query: cubit.searchQuery,
                  );
                  print('${param.query} 🔍🔍🔍');

                  await downloader.downloadFile(
                    context,
                    '${kBaseUrl}school/all/?is_csv_response=true&${param.toQueryParams()}',
                    'schools.csv',
                  );
            },
          ),
          // //
        ],
      ),
      body: SchoolViewBody(),

      floatingActionButton: ReseveDataSchoolActionButton(
        context: context,
        colorScheme: colorScheme,
      ),
    );
  }
}
