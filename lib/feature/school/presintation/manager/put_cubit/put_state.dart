part of 'put_cubit.dart';

@immutable
sealed class UpdateState {}

final class PutInitialState extends UpdateState {}

final class UpdateLoadingState extends UpdateState {}

final class UpdateSuccessState extends UpdateState {
  final SchoolModel schoolModel;

  UpdateSuccessState({required this.schoolModel});
}

final class UpdateFailureState extends UpdateState {
  final String errMessage;

  UpdateFailureState({required this.errMessage});
}

final class UpdateOfflineState extends UpdateState {
  final String errMessage;

  UpdateOfflineState({required this.errMessage});
}
