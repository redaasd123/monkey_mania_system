part of 'anlytic_cubit.dart';

enum AnalyticStatus { loading, failure, success, initial }

class AnalyticState extends Equatable {
  final AnalyticStatus status;
  final String? errMessage;
  final List<AnalyticTypeEntity> data;
  final RequestParameters filters;

  const AnalyticState({
    this.filters =const RequestParameters(),
    this.errMessage,
    this.data = const [],
    this.status = AnalyticStatus.initial,
  });

  AnalyticState copyWith({
    RequestParameters? filters,
    AnalyticStatus? status,
    String? errMessage, List<AnalyticTypeEntity>? data}) {
    return AnalyticState(
      filters: filters??this.filters,
      status: status??this.status,
      data: data ?? this.data,
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [data, errMessage,status, filters];
}
