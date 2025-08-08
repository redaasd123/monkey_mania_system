part of 'close_bills_cubit.dart';

@immutable
sealed class CloseBillsState {}

final class CloseBillsInitial extends CloseBillsState {}
final class CloseBillsLoading extends CloseBillsState {}
final class CloseBillsFailure extends CloseBillsState {
  final String errMessage;
  CloseBillsFailure({required this.errMessage});
}
final class CloseBillsSuccess extends CloseBillsState {}
