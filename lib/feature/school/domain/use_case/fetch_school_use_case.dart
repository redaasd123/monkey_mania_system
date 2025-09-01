import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../entity/school_entity.dart';
import '../repo/school_repo.dart';

class FetchSchoolUseCase extends MyUseCase<List<SchoolEntity>, String> {
  final SchoolRepo schoolRpo;

  FetchSchoolUseCase({required this.schoolRpo});

  @override
  Future<Either<Failure, List<SchoolEntity>>> call(String query) async {
    return await schoolRpo.fetchSchools(query);
  }
}
