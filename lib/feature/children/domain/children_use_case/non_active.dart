import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/children/domain/children_repo/children_repo.dart';
import 'package:monkey_app/feature/children/domain/entity/children/non_active.dart';
import 'package:monkey_app/feature/children/domain/param/fetch_children_param.dart';

class ChildrenNonActiveUseCase
    extends MyUseCase<List<ChildrenNonActiveEntity>, FetchChildrenParam> {
  final ChildrenRepo childrenRepo;

  ChildrenNonActiveUseCase({required this.childrenRepo});

  @override
  Future<Either<Failure, List<ChildrenNonActiveEntity>>> call(
    FetchChildrenParam param,
  ) async {
    return await childrenRepo.childrenNonActive(param);
  }
}
