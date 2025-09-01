import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../../../core/param/update_school_param/update_school_param.dart';
import '../../data/model/school_model.dart';
import '../entity/school_entity.dart';
import '../repo/school_repo.dart';

class UpdateSchoolUseCase extends MyUseCase<SchoolEntity, UpdateSchoolParam> {
  final SchoolRepo schoolRpo;

  UpdateSchoolUseCase({required this.schoolRpo});

  @override
  Future<Either<Failure, SchoolEntity>> call(UpdateSchoolParam param) async {
    return await schoolRpo.updateSchool(param);
  }
}
