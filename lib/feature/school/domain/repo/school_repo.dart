import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';

import '../../data/model/school_model.dart';
import '../entity/school_entity.dart';

abstract class SchoolRepo{
 Future<Either<Failure,List<SchoolEntity>>> fetchSchools();
 Future<Either<Failure,SchoolModel>> postSchool(
     {required String name,required String address, String? notes});
 Future<Either<Failure,SchoolModel>> updateSchool(
     {required String name,required String address, String? notes,required int id});


}