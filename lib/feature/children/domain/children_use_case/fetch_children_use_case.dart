import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';

import '../entity/children/children_entity.dart';
import '../entity/children/children_page_entity.dart';
import '../param/fetch_children_param.dart';

class FetchChildrenUseCase extends MyUseCase<ChildrenPageEntity, FetchChildrenParam> {
  final ChildrenRepo childrenRepo;

  FetchChildrenUseCase({required this.childrenRepo});

  @override
  Future<Either<Failure, ChildrenPageEntity>> call(FetchChildrenParam? param) async {
    return await childrenRepo.fetchChildren(param);
  }
}
