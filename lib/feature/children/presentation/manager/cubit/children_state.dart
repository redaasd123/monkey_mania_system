part of 'children_cubit.dart';

@immutable
sealed class ChildrenState {}

final class ChildrenInitial extends ChildrenState {}

final class ChildrenSuccessState extends ChildrenState {
  final List<ChildrenEntity> children;

  ChildrenSuccessState({required this.children});
}

final class ChildrenFailureState extends ChildrenState {
  final String errMessage;

  ChildrenFailureState({required this.errMessage});
}

final class ChildrenLoadingState extends ChildrenState {}

final class ChildrenSelectedState extends ChildrenState {
  final ChildrenEntity selectChildren;

  ChildrenSelectedState({required this.selectChildren});
}

final class ChildrenToggleState extends ChildrenState {
  final bool isSearch;

  ChildrenToggleState({required this.isSearch});
}

final class ChildrenSearchResultState extends ChildrenState {}
