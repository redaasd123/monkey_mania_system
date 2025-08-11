part of 'get_one_bills_cubit.dart';

@immutable
sealed class GetOneBillsState {}

final class GetOneBillsInitial extends GetOneBillsState {}

final class GetOneBillsLoadingState extends GetOneBillsState {}

final class GetOneBillsFailureState extends GetOneBillsState {
  final String errMessage;

  GetOneBillsFailureState({required this.errMessage});
}

final class GetOneBillsSuccessState extends GetOneBillsState {
  final GetOneBillsEntity bills;

  GetOneBillsSuccessState({required this.bills});
}
