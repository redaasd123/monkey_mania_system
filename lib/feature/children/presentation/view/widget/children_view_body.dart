import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_list_view.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/reseve_data_floating_actio_button.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/search_children_builder.dart';
import '../../../../../branch_service.dart';
import '../../../../../core/utils/langs_key.dart';
import 'children_bloc_builder_list_view.dart';

class ChildrenViewBody extends StatefulWidget {
  const ChildrenViewBody({super.key});

  @override
  State<ChildrenViewBody> createState() => _ChildrenViewBodyState();
}

class _ChildrenViewBodyState extends State<ChildrenViewBody> {
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: const Icon(Icons.more_vert, color: Colors.white),
          ),
          onSelected: (value) {
            if (value == 'branch') {
              BranchService().showBranchList(context);
            } else if (value == 'date') {
              BranchService().showDateBicker(context);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<String>(value: 'branch', child: Text('Branch')),
            const PopupMenuItem<String>(
              value: 'date',
              child: Text('DateBiker'),
            ),
          ],
        ),

        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<ChildrenCubit, ChildrenState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<ChildrenCubit>(context);
            final isSearch = cubit.isSearching;
            return isSearch
                ? SizedBox(
                    height: 40,
                    child: TextField(
                      controller: nameCtrl,
                      onChanged: (query) {
                        BlocProvider.of<ChildrenCubit>(
                          context,
                        ).searchChild(query);
                      },
                      style: TextStyle(
                        color: colorScheme.onPrimary, // لون النص جوه TextField
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
                        fillColor: colorScheme.primary, // نفس لون AppBar
                      ),
                    ),
                  )
                : Text('');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              final cubit = BlocProvider.of<ChildrenCubit>(context);
              if (cubit.isSearching) {
                cubit.closeSearch();
                nameCtrl.clear();
              } else {
                cubit.toggleChildren();
                nameCtrl.clear();
              }
            },
            icon: BlocBuilder<ChildrenCubit, ChildrenState>(
              builder: (context, state) {
                final isSearch = BlocProvider.of<ChildrenCubit>(
                  context,
                ).isSearching;
                return isSearch ? Icon(Icons.close) : Icon(Icons.search);
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ChildrenCubit, ChildrenState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<ChildrenCubit>(context);

          if (cubit.selectChild != null && !cubit.isSearching) {
            return ChildrenListView(children: [cubit.selectChild!]);
          }
          return ChildrenListView(children: cubit.filterChildren);
        },
      ),
      floatingActionButton: ReseveDataChildrenActionButton(context),
    );
  }
}
