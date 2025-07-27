part of 'post_cubit.dart';

@immutable
sealed class CreateSchoolState {}

final class CreateInitialState extends CreateSchoolState {}

final class CreateLoadingState extends CreateSchoolState {}

final class CreateSuccessState extends CreateSchoolState {
  final SchoolModel schoolModel;

  CreateSuccessState({required this.schoolModel});
}

final class CreateFailureState extends CreateSchoolState {
  final String errMessage;

  CreateFailureState({required this.errMessage});
}

final class CreateOfflineState extends CreateSchoolState {
  final String errMessage;

  CreateOfflineState({required this.errMessage});
}