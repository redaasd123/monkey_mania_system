import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_state.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_view_body.dart';

import '../../../../core/utils/langs_key.dart';

class ChildrenView extends StatefulWidget {
  const ChildrenView({super.key});

  @override
  State<ChildrenView> createState() => _ChildrenViewState();
}

class _ChildrenViewState extends State<ChildrenView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<ChildrenCubit, ChildrenState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              title: BlocBuilder<ChildrenCubit, ChildrenState>(
                builder: (context, state) {
                  final cubit = context.read<ChildrenCubit>();
                  return state.isSearching
                      ? TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
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
                    onChanged: (val){
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
                      final cubit = context.read<ChildrenCubit>();
                      return Icon(state.isSearching ? Icons.close : Icons.search);
                    },
                  ),
                  onPressed: () {
                    setState(() {
                      context.read<ChildrenCubit>().toggleSearch();
                    });
                  },
                ),

              ],
            ),
          body: const ChildrenViewBody(),
        );
      },
    );
  }
}
