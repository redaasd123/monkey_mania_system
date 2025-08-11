import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';

import '../../../../core/param/create_children_params/create_children_params.dart';

class CreateChildUseCase extends MyUseCase<dynamic, CreateChildrenParam> {
  final ChildrenRepo childrenRepo;

  CreateChildUseCase({required this.childrenRepo});

  @override
  Future<Either<Failure, dynamic>> call(CreateChildrenParam param) async {
    return await childrenRepo.createChildren(param);
  }
}
