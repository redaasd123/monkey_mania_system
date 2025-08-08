part of 'fetch_active_bills_cubit.dart';

@immutable
sealed class FetchActiveBillsState {}

final class FetchActiveBillsInitial extends FetchActiveBillsState {}
final class FetchActiveBillsLoadingState extends FetchActiveBillsState {}

final class FetchActiveBillsSuccessState extends FetchActiveBillsState{
  final List<BillsEntity> bills;
  FetchActiveBillsSuccessState({required this.bills});
}

final class FetchActiveBillsFailureState extends FetchActiveBillsState {
  final String errMessage;

  FetchActiveBillsFailureState({required this.errMessage});
}
