import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';

import '../../../../core/param/update_children_param/update_children_param.dart';


class UpdateChildrenUseCase extends MyUseCase<dynamic,UpdateChildrenParam>{
  final ChildrenRepo childrenRepo;

  UpdateChildrenUseCase({required this.childrenRepo});
  @override
  Future<Either<Failure, dynamic>> call(UpdateChildrenParam param) async{
    return await childrenRepo.updateChildren(param);

  }
}