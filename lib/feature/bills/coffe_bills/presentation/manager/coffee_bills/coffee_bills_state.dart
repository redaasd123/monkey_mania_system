part of 'coffee_bills_cubit.dart';

@immutable
sealed class CoffeeBillsState {}

final class CoffeeBillsInitial extends CoffeeBillsState {}

final class CoffeeBillsLoadingState extends CoffeeBillsState {}

final class CoffeeBillsFailureState extends CoffeeBillsState {
  final String errMessage;

  CoffeeBillsFailureState({required this.errMessage});
}

final class CoffeeBillsSuccessState extends CoffeeBillsState {
  final List<BillsCoffeeEntity> bills;

  CoffeeBillsSuccessState({required this.bills});
}

final class ActiveCoffeeBillsInitial extends CoffeeBillsState {}

final class ActiveCoffeeBillsLoadingState extends CoffeeBillsState {}

final class ActiveCoffeeBillsFailureState extends CoffeeBillsState {
  final String errMessage;

  ActiveCoffeeBillsFailureState({required this.errMessage});
}

final class ActiveCoffeeBillsSuccessState extends CoffeeBillsState {
  final List<BillsCoffeeEntity> bills;

  ActiveCoffeeBillsSuccessState({required this.bills});
}

final class GetOneBillsInitial extends CoffeeBillsState {}

final class GetOneBillsCoffeeLoadingState extends CoffeeBillsState {}

final class GetOneBillsCoffeeFailureState extends CoffeeBillsState {
  final String errMessage;

  GetOneBillsCoffeeFailureState({required this.errMessage});
}

final class GetOneBillsCoffeeSuccessState extends CoffeeBillsState {
  final GetOneBillsCoffeeEntity bills;

  GetOneBillsCoffeeSuccessState({required this.bills});
}
