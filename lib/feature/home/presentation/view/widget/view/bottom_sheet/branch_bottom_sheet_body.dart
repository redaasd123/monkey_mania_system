import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';

import '../../../../../../branch/presentation/manager/branch_cubit.dart';

class BranchBottomSheetBody extends StatelessWidget {
  const BranchBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchCubit, BranchState>(
      builder: (context, state) {
        if (state is BranchSuccessState) {
          final List<int> selectIndex = [];
          final branches = state.branch;
          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: branches.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectIndex.contains(index);
                      return ListTile(
                        title: Text(branches[index].name ?? ''),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : const Icon(Icons.circle_outlined),
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectIndex.remove(index);
                            } else {
                              selectIndex.add(index);
                            }
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async{
                      final isSelectBranch = selectIndex.isNotEmpty;
                      final selectBranch = selectIndex.map((b)=>branches[b]).toList();
                      final selectId = selectBranch.map((i)=>i.id.toString()).join(',');
                      try {
                        final response = await getIt.get<Api>().get(
                          endPoint: 'branch/all/',
                          queryParameters: {
                            'branch_id': isSelectBranch ? selectId : 'all',
                            'start_date': '2023-5-5',
                            'end_date': '2027-5-9',
                          },
                        );
                        print(response); // ✅ هنا تتعامل مع البيانات

                      } catch (e) {
                        print('❌ Error: $e'); // أو ممكن تظهر Alert للمستخدم
                      }

                    },
                    child: const Text('تم'),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        } else if (state is BranchInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: SizedBox());
        }
      },
    );
  }
}

// final selectedBranches = selectIndex
//                           .map((index) => branches[index])
//                           .toList();
//                       Navigator.pop(context);
//                     //  print('الفروع المختارة: ${selectedBranches.map((b) => b.name).toList()}');
//
