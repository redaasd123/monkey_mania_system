import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/langs_key.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/widget/widget/custom_flush.dart';
import '../../../../branch/presentation/manager/branch_cubit.dart';

class SelectBranchWithLogin extends StatefulWidget {
  const SelectBranchWithLogin({super.key});

  @override
  State<SelectBranchWithLogin> createState() => _SelectBranchWithLoginState();
}

class _SelectBranchWithLoginState extends State<SelectBranchWithLogin> {
  int? selectIndex;
  dynamic? currentBranch;

  @override
  void initState() {
    currentBranch = AuthHelper.getBranch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return BlocBuilder<BranchCubit, BranchState>(
      builder: (context, state) {
        if (state.status == BranchStatus.loading) {
          return const Center(
            child: SpinKitFadingCircle(size: 60, color: Colors.blue),
          );
        }

        if (state.status == BranchStatus.success && state.branches != null) {
          final branches = state.branches!;
          int? selectedIndex = branches.indexWhere(
            (b) => b.id == state.selectedBranchId,
          );

          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.background, color.primary.withOpacity(0.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        LangKeys.selectBranch.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.primary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: branches.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final isSelected = selectedIndex == index;
                            final branch = branches[index];

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: isSelected
                                        ? [Colors.greenAccent, Colors.green]
                                        : [
                                            Colors.grey.shade200,
                                            Colors.grey.shade300,
                                          ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        branch.name ?? '',
                                        style: TextStyle(
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      isSelected
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 6,
                            backgroundColor: color.primary,
                          ),
                          onPressed: () {
                            if (selectedIndex == null) {
                              showRedFlush(
                                context,
                                LangKeys.chooseAtLeastOneBranch.tr(),
                              );
                              return;
                            }

                            final selectedBranch = branches[selectedIndex!].id;
                            context.read<BranchCubit>().selectBranch(
                              selectedBranch??0,
                            );

                            Navigator.pop(context, selectedBranch);
                          },
                          child: Text(
                            LangKeys.ok.tr(),
                            style: Styles.textStyle20.copyWith(
                              color: color.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
