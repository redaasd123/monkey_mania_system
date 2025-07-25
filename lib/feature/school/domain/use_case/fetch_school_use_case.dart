import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../data/model/school_model.dart';
import '../entity/school_entity.dart';
import '../repo/school_repo.dart';

class FetchSchoolUseCase extends MyUseCase<List<SchoolEntity>,NoParam>{
  final SchoolRepo schoolRpo;

  FetchSchoolUseCase({required this.schoolRpo});

  @override
  Future<Either<Failure, List<SchoolEntity>>> call([NoParam? param])async {
    return await schoolRpo.fetchSchools();
  }

}