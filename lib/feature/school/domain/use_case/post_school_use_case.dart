import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/use_case/params/post_school_param.dart';
import 'package:monkey_app/feature/school/data/model/school_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repo/school_repo.dart';

class PostSchoolUseCase extends MyUseCase<SchoolModel, PostSchoolParam> {
  final  SchoolRepo schoolRepo;

  PostSchoolUseCase({required this.schoolRepo});

  @override
  Future<Either<Failure, SchoolModel>> call(PostSchoolParam param) {
    // تم تمرير كافة الحقول كما هي، notes قد تكون null
    return schoolRepo.postSchool(
      name: param.name,
      address: param.address,
      notes: param.notes,
    );
  }
}
