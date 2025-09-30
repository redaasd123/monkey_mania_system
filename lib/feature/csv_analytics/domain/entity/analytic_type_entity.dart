import 'package:equatable/equatable.dart';

class AnalyticTypeEntity extends Equatable {
  final String name;
  const AnalyticTypeEntity({required this.name});
  List<Object?> get props =>[name];
}