  import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginRepo{
Future<Either<Failure,dynamic>>LoginUser({required String pass,required String phone});
}