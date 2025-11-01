part of 'home_cubit.dart';

enum HomeStatus { loading, failure, success, initial }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errMessage;
  final HomeEntity? data;

  const HomeState({
    this.status = HomeStatus.initial,
    this.errMessage,
    this.data,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errMessage,
    HomeEntity? data,
  }) {
    return HomeState(
      errMessage: errMessage ?? this.errMessage,
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [errMessage, status, data];
}
