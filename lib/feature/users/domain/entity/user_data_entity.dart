import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final String name;
  final String role;
  final String phoneNumber;
  final String? email;
  final int id;

  const UserDataEntity({
    this.email,
    required this.id,
    required this.name,
    required this.role,
    required this.phoneNumber,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, role, phoneNumber, id,email];
}
