import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';

import '../entity/children/children_entity.dart';

class FetchChildrenUseCase extends  MyUseCase<List<ChildrenEntity>,NoParam>{
 final ChildrenRepo childrenRepo;

  FetchChildrenUseCase({required this.childrenRepo});
  @override
  Future<Either<Failure, List<ChildrenEntity>>> call(NoParam? param) async{
    return await childrenRepo.fetchChildren();
  }



}