part of 'branch_cubit.dart';

@immutable
sealed class BranchState {}

final class BranchInitial extends BranchState {}

final class BranchLoadingState extends BranchState {}

final class BranchFailureState extends BranchState {
  final String errMessage;

  BranchFailureState({required this.errMessage});
}

final class BranchSuccessState extends BranchState {
  final List<BranchEntity> branch;

  BranchSuccessState({required this.branch});
}
