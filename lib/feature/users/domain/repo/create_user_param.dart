import 'package:equatable/equatable.dart';

class CreateUserParam extends Equatable {
  final String userName;
  final int branch;
  final String? password;
  final String? confirmPass;
  final String phoneNumber;
  final String role;
  final String? email;

  const CreateUserParam({
     this.email,
    required this.userName,
    required this.branch,
     this.password,
     this.confirmPass,
    required this.phoneNumber,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    final data = {
      "username": userName,
      "branch": branch,
      "phone_number": phoneNumber,
      "role": role,
    };

    if (password != null && password!.trim().isNotEmpty) {
      data['password'] = password!;
    }

    if (confirmPass != null && confirmPass!.trim().isNotEmpty) {
      data['confirm_password'] = confirmPass!;
    }

    if (email != null && email!.trim().isNotEmpty) {
      data["email"] = email!;
    }

    return data;
  }


  @override
  // TODO: implement props
  List<Object?> get props => [
    email,
    userName,
    branch,
    password,
    confirmPass,
    role,
    phoneNumber,
  ];
}
