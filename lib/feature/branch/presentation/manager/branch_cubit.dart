import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/feature/branch/domain/entity/branch_entity.dart';
import 'package:monkey_app/feature/branch/domain/use_case/branch_use_case.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final BranchUseCase branchUseCase;

  BranchCubit(this.branchUseCase) : super(const BranchState());

  Future<void> fetchBranches() async {
    emit(state.copyWith(status: BranchStatus.loading));

    final result = await branchUseCase.call(NoParam());

    result.fold(
          (failure) => emit(state.copyWith(
        status: BranchStatus.failure,
        errorMessage: failure.errMessage,
      )),
          (branches) => emit(state.copyWith(
        status: BranchStatus.success,
        branches: branches,
      )),
    );
  }
  void saveSelectedBranches(List<int> branches) {
    emit(state.copyWith(savedBranches: branches));
  }

  void selectBranch(int branchId) {
    Hive.box(kAuthBox).put(AuthKeys.branch, branchId);
    emit(state.copyWith(
      status: BranchStatus.selected,
      selectedBranchId: branchId,
    ));
  }
}
