import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/reseve_data_school_action_button.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/school_list_view.dart';

class SchoolViewBody extends StatefulWidget {
  const SchoolViewBody({super.key});

  @override
  State<SchoolViewBody> createState() => _SchoolViewBodyState();
}

class _SchoolViewBodyState extends State<SchoolViewBody> {
  final searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SchoolCubit>().canselSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<SchoolCubit, SchoolState>(
          builder: (context, state) {
            final isSearching = context.read<SchoolCubit>().isSearch;
            return isSearching
                ? SizedBox(
                    height: 40,
                    child: TextField(
                      controller: searchCtrl,
                      onChanged: (query) {
                        context.read<SchoolCubit>().searchSchools(query);
                      },
                      style: TextStyle(
                        color: colorScheme.onPrimary, // لون النص جوه TextField
                      ),
                      cursorColor: colorScheme.onPrimary,
                      decoration: InputDecoration(
                        hintText: LangKeys.school.tr(),
                        hintStyle: TextStyle(
                          color: colorScheme.onPrimary.withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        filled: true,
                        fillColor: colorScheme.primary, // نفس لون AppBar
                      ),
                    ),
                  )
                : Text(
                    LangKeys.school.tr(),
                    style: TextStyle(color: colorScheme.onPrimary),
                  );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              final cubit = context.read<SchoolCubit>();
              if (cubit.isSearch) {
                cubit.canselSearch();
                searchCtrl.clear();
              } else {
                cubit.toggleSearch();
                searchCtrl.clear();
              }
            },
            icon: BlocBuilder<SchoolCubit, SchoolState>(
              builder: (context, state) {
                final isSearching = context.read<SchoolCubit>().isSearch;
                return Icon(
                  isSearching ? Icons.close : Icons.search,
                  color: colorScheme.onPrimary,
                  size: 28,
                );
              },
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SchoolCubit, SchoolState>(
          builder: (context, state) {
            final cubit = context.read<SchoolCubit>();

            if (cubit.selectedSchool != null && !cubit.isSearch) {
              cubit.fetchSchool();
              return SchoolListView(school: [cubit.selectedSchool!]);
            }

            return SchoolListView(school: cubit.filteredSchools);
          },
        ),
      ),

      floatingActionButton: ReseveDataSchoolActionButton(
        context: context,
        colorScheme: colorScheme,
      ),
    );
  }
}
