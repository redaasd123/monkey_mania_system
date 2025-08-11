import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/branch/domain/entity/branch_entity.dart';

abstract class BranchRepo {
  Future<Either<Failure, List<BranchEntity>>> fetchBranch();
}
