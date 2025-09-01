part of 'coffee_bills_cubit.dart';

@immutable
sealed class CoffeeBillsState extends Equatable {
  const CoffeeBillsState();
}

final class CoffeeBillsInitial extends CoffeeBillsState {
  const CoffeeBillsInitial();

  @override
  List<Object?> get props => [];
}

final class CoffeeBillsLoadingState extends CoffeeBillsState {
  const CoffeeBillsLoadingState();

  @override
  List<Object?> get props => [];
}

final class CoffeeBillsFailureState extends CoffeeBillsState {
  final String errMessage;

  const CoffeeBillsFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

final class CoffeeBillsSuccessState extends CoffeeBillsState {
  final List<BillsCoffeeEntity> bills;

  const CoffeeBillsSuccessState({required this.bills});

  @override
  List<Object?> get props => [bills];
}

final class ActiveCoffeeBillsInitial extends CoffeeBillsState {
  const ActiveCoffeeBillsInitial();

  @override
  List<Object?> get props => [];
}

final class ActiveCoffeeBillsLoadingState extends CoffeeBillsState {
  const ActiveCoffeeBillsLoadingState();

  @override
  List<Object?> get props => [];
}

final class ActiveCoffeeBillsFailureState extends CoffeeBillsState {
  final String errMessage;

  const ActiveCoffeeBillsFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

final class ActiveCoffeeBillsSuccessState extends CoffeeBillsState {
  final List<BillsCoffeeEntity> bills;

  const ActiveCoffeeBillsSuccessState({required this.bills});

  @override
  List<Object?> get props => [bills];
}

final class GetOneBillsInitial extends CoffeeBillsState {
  const GetOneBillsInitial();

  @override
  List<Object?> get props => [];
}

final class GetOneBillsCoffeeLoadingState extends CoffeeBillsState {
  const GetOneBillsCoffeeLoadingState();

  @override
  List<Object?> get props => [];
}

final class GetOneBillsCoffeeFailureState extends CoffeeBillsState {
  final String errMessage;

  const GetOneBillsCoffeeFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

final class GetOneBillsCoffeeSuccessState extends CoffeeBillsState {
  final GetOneBillsCoffeeEntity bills;

  const GetOneBillsCoffeeSuccessState({required this.bills});

  @override
  List<Object?> get props => [bills];
}

final class CreateBillsCoffeeFailureState extends CoffeeBillsState {
  final String errMessage;

  const CreateBillsCoffeeFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

final class CreateBillsCoffeeSuccessState extends CoffeeBillsState {
  const CreateBillsCoffeeSuccessState();

  @override
  List<Object?> get props => [];
}

final class CreateBillsCoffeeLoadingState extends CoffeeBillsState {
  const CreateBillsCoffeeLoadingState();
  @override
  List<Object?> get props => [];
}
final class BillsEmptyState extends CoffeeBillsState{
  @override
  List<Object?> get props => [];
}
final class ActiveBillsSearchLoading extends CoffeeBillsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}