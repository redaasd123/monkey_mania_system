part of 'get_one_bills_coffee_cubit.dart';

enum GetOneBillsCoffeeStatus { initial, getOneLoading, getOneFailure, getOneSuccess }

class GetOneBillsCoffeeState extends Equatable {
  final GetOneBillsCoffeeStatus status;
  final GetOneBillsCoffeeEntity? getOneBills;
  final String? errMessage;

  const GetOneBillsCoffeeState({
    this.status = GetOneBillsCoffeeStatus.initial,
    this.getOneBills,
    this.errMessage,
  });

  GetOneBillsCoffeeState copyWith({
    GetOneBillsCoffeeStatus? status,
    GetOneBillsCoffeeEntity? getOneBills,
    String? errMessage,
  }) {
    return GetOneBillsCoffeeState(
      status: status ?? this.status,
      getOneBills: getOneBills ?? this.getOneBills,
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [status, getOneBills, errMessage];
}
