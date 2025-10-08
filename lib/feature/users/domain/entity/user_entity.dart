import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';

class UserEntity extends Equatable {
  final int? next;
  final int? previous;
  final List<UserDataEntity> userData;

  const UserEntity({
    required this.next,
    required this.previous,
    required this.userData,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [next, previous, userData];
}
