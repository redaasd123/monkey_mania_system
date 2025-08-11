part of 'create_child_cubit.dart';

@immutable
sealed class CreateChildState {}

final class CreateChildInitial extends CreateChildState {}

final class CreateChildLoading extends CreateChildState {}

final class CreateChildFailure extends CreateChildState {
  final String errMessage;

  CreateChildFailure({required this.errMessage});
}

class CreateChildSuccess extends CreateChildState {}

class CreateChildOfflineSaved extends CreateChildState {
  final String message;

  CreateChildOfflineSaved(this.message);
} // ✅ جديد
