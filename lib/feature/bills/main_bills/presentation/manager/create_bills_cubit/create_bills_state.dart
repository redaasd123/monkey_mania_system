part of 'create_bills_cubit.dart';

@immutable
sealed class CreateBillsState {}

final class CreateBillsInitial extends CreateBillsState {}

final class CreateBillsLoadingState extends CreateBillsState {}

final class CreateBillsFailureState extends CreateBillsState {
  final String errMessage;

  CreateBillsFailureState({required this.errMessage});
}

final class CreateBillsSuccessState extends CreateBillsState {}
