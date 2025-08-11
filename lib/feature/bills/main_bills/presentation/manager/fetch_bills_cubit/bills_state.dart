part of 'bills_cubit.dart';

@immutable
sealed class BillsState {}

final class BillsInitial extends BillsState {}

final class BillsLoadingState extends BillsState {}

final class BillsSuccessState extends BillsState {
  final List<BillsEntity> bills;

  BillsSuccessState({required this.bills});
}

final class BillsFailureState extends BillsState {
  final String errMessage;

  BillsFailureState({required this.errMessage});
}
