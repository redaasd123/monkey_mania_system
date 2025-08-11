import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/branch/domain/entity/branch_entity.dart';
import 'package:monkey_app/feature/branch/domain/use_case/branch_use_case.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final BranchUseCase branchUseCase;

  BranchCubit(this.branchUseCase) : super(BranchInitial());

  Future<void> fetchBranch() async {
    emit(BranchLoadingState());
    var result = await branchUseCase.call(NoParam());
    result.fold(
      (failure) => emit(BranchFailureState(errMessage: failure.errMessage)),
          (branch) => emit(BranchSuccessState(branch: branch)),
    );
  }
}
