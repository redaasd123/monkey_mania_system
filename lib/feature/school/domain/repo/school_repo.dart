import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/param/create_school_param/create_school_param.dart';
import 'package:monkey_app/core/param/update_school_param/update_school_param.dart';

import '../../data/model/school_model.dart';
import '../entity/school_entity.dart';

abstract class SchoolRepo {
  Future<Either<Failure, List<SchoolEntity>>> fetchSchools();

  Future<Either<Failure, SchoolModel>> createSchool(CreateSchoolParam param);

  Future<Either<Failure, SchoolModel>> updateSchool(UpdateSchoolParam param);
}
