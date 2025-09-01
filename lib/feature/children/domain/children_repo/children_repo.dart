import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';

import '../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../core/param/update_children_param/update_children_param.dart';
import '../entity/children/children_page_entity.dart';
import '../param/fetch_children_param.dart';

abstract class ChildrenRepo {
  Future<Either<Failure, ChildrenPageEntity>> fetchChildren(FetchChildrenParam? param);

  Future<Either<Failure, ChildrenEntity>> createChildren(CreateChildrenParam param);

  Future<Either<Failure, ChildrenEntity>> updateChildren(UpdateChildrenParam param);
}
