import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/params/put_params.dart';
import 'package:monkey_app/core/use_case/use_case.dart';

import '../../data/model/school_model.dart';
import '../repo/school_repo.dart';

class UpdateSchoolUseCase extends MyUseCase<SchoolModel,UpdateSchoolParam>{
  final SchoolRepo schoolRpo;

  UpdateSchoolUseCase({required this.schoolRpo});

  @override
  Future<Either<Failure, SchoolModel>> call(UpdateSchoolParam param)async {
    return await schoolRpo.updateSchool(name: param.name,
        address: param.address,notes: param.notes,
    id: param.id);
  }


}