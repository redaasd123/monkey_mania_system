part of 'apply_discount_cubit.dart';

@immutable
sealed class ApplyDiscountState {}

final class ApplyDiscountInitial extends ApplyDiscountState {}

final class ApplyDiscountLoadingState extends ApplyDiscountState {}

final class ApplyDiscountFailureState extends ApplyDiscountState {
  final String errMessage;

  ApplyDiscountFailureState({required this.errMessage});
}

final class ApplyDiscountSuccessState extends ApplyDiscountState {}