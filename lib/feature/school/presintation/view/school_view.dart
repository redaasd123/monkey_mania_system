import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/reseve_data_school_action_button.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/school_view_body.dart';

import '../../../../core/download_fiels/download_file.dart';
import '../../../../core/utils/constans.dart';
import '../../../bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import '../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../branch/presentation/view/show_branch_bottom_sheet.dart';

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

            PopupMenuButton<String>(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[900]!.withOpacity(0.95)
                  : Colors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 10,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFC971E4), Color(0xFFC0A7C6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.more_vert, color: Colors.white, size: 22),
              ),
              onSelected: (value) async {
                if (value == 'download') {
                  // هنا نضع الكود بتاع التحميل مباشرة
                  final cubit = context.read<SchoolCubit>().state;
                  await requestStoragePermission();
                  final downloader = FileDownloaderUI();
                  final FetchBillsParam param = FetchBillsParam(
                    query: cubit.searchQuery,
                  );
                  print('${param.query} 🔍🔍🔍');

                  await downloader.downloadFile(
                    context,
                    '${kBaseUrl}school/all/?is_csv_response=true&${param.toQueryParams()}',
                    'schools.csv',
                  );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'download',
                  child: Row(
                    children: [
                      Icon(
                        Icons.download,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Download',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

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
