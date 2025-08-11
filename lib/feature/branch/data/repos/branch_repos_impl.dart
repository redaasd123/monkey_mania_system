import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/branch/data/data_source/branch_remote_data_source.dart';
import 'package:monkey_app/feature/branch/domain/entity/branch_entity.dart';

import '../../domain/repo/branch_repo.dart';

class BranchRepoImpl extends BranchRepo {
  final BranchRemoteDataSource branchRemoteDataSource;

  BranchRepoImpl({required this.branchRemoteDataSource});

  @override
  Future<Either<Failure, List<BranchEntity>>> fetchBranch() async {
    try {
      var result = await branchRemoteDataSource.fetchBranch();
      print("${result}🤨🤨🤨🤨🤨🤨🤨🤨🤨");
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
