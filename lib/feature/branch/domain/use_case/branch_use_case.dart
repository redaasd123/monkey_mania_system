import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/branch/domain/entity/branch_entity.dart';
import 'package:monkey_app/feature/branch/domain/repo/branch_repo.dart';

class BranchUseCase extends MyUseCase<List<BranchEntity>, NoParam> {
  final BranchRepo branchRepo;

  BranchUseCase({required this.branchRepo});

  @override
  Future<Either<Failure, List<BranchEntity>>> call(NoParam param) async {
    return await branchRepo.fetchBranch();
  }
}
