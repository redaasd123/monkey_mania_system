import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/data/data_source/bills_remote_data_source.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/domain/repo/bills_repo.dart';

import '../../domain/repo/fetch_bills_param.dart';

class BillsRepoImpl extends BillsRepo {
  final BillsRemoteDataSource billsRemoteDataSource;

  BillsRepoImpl({required this.billsRemoteDataSource});

  @override
  Future<Either<Failure, List<BillsEntity>>> fetchBills(FetchBillsPram param) async {
    try {
      var result = await billsRemoteDataSource.fetchBills(param);
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
