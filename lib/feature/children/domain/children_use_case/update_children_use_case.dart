import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';

import '../../../../core/param/update_children_param/update_children_param.dart';
import '../entity/children/children_entity.dart';

class UpdateChildrenUseCase extends MyUseCase<ChildrenEntity, UpdateChildrenParam> {
  final ChildrenRepo childrenRepo;

  UpdateChildrenUseCase({required this.childrenRepo});

  @override
  Future<Either<Failure, ChildrenEntity>> call(UpdateChildrenParam param) async {
    return await childrenRepo.updateChildren(param);
  }
}
