import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_bloc_builder_list_view.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/reseve_data_floating_actio_button.dart';

import '../../../../../core/download_fiels/download_file.dart';
import '../../../../../core/secret/secret.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/utils/poppup_menu_button.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../manager/cubit/children_cubit.dart';
import '../../manager/cubit/children_state.dart';

class ChildrenViewBody extends StatefulWidget {
  const ChildrenViewBody({super.key});

  @override
  State<ChildrenViewBody> createState() => _ChildrenViewBodyState();
}

class _ChildrenViewBodyState extends State<ChildrenViewBody> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<ChildrenCubit, ChildrenState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: ReseveDataChildrenActionButton(context),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            title: BlocBuilder<ChildrenCubit, ChildrenState>(
              builder: (context, state) {
                final cubit = context.read<ChildrenCubit>();
                return state.isSearching
                    ? TextField(
                        autofocus: true,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        cursorColor: colorScheme.onPrimary,
                        decoration: InputDecoration(
                          hintText: LangKeys.children.tr(),
                          hintStyle: TextStyle(
                            color: colorScheme.onPrimary.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          filled: true,
                          fillColor: colorScheme.primary,
                        ),
                        onChanged: (val) {
                          cubit.searchChildren(val);
                        },
                      )
                    : Text(
                        LangKeys.children.tr(),
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
                icon: BlocBuilder<ChildrenCubit, ChildrenState>(
                  builder: (context, state) {
                    return Icon(state.isSearching ? Icons.close : Icons.search);
                  },
                ),
                onPressed: () {
                  setState(() {
                    context.read<ChildrenCubit>().toggleSearch();
                  });
                },
              ),
              CustomPopupMenu(
                onDownload: () async {
                  final cubit = context.read<ChildrenCubit>().state;
                  await requestStoragePermission();
                  final downloader = FileDownloaderUI();
                  final param = RequestParameters(query: cubit.searchQuery);
                  final url =
                      '${kBaseUrl}child/all/?is_csv_response=true&${param.toQueryParams()}';
                  await downloader.downloadFile(context, url, ',children.csv');
                },
              ),
            ],
          ),
          body: const ChildrenBlocBuilderListView(),
        );
      },
    );

    //();
  }
}
