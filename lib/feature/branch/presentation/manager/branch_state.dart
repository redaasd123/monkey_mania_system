part of 'branch_cubit.dart';

enum BranchStatus { initial, loading, success, failure, selected }

@immutable
class BranchState extends Equatable {
  final List<dynamic>? savedBranches;
  final DateTime? startDate;
  final DateTime? endDate;
  final BranchStatus status;
  final List<BranchEntity>? branches;
  final int? selectedBranchId;
  final String? errorMessage;

  const BranchState({
    this.startDate,
    this.endDate,
    this.savedBranches,
    this.status = BranchStatus.initial,
    this.branches,
    this.selectedBranchId,
    this.errorMessage,
  });

  BranchState copyWith({
    DateTime? endDate,
    DateTime? startDate,
    List<dynamic>? savedBranches,
    BranchStatus? status,
    List<BranchEntity>? branches,
    int? selectedBranchId,
    String? errorMessage,
  }) {
    return BranchState(
      endDate: endDate??this.endDate,
      startDate: startDate??this.startDate,
      savedBranches: savedBranches ?? this.savedBranches,
      status: status ?? this.status,
      branches: branches ?? this.branches,
      selectedBranchId: selectedBranchId ?? this.selectedBranchId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    branches,
    selectedBranchId,
    errorMessage,
    savedBranches,
  ];
}
