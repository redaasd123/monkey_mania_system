import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/children/children_entity.dart';

@immutable
// sealed class ChildrenState {}
//
// // -------------------- Fetch Children States --------------------
// final class ChildrenInitial extends ChildrenState {}
//
// final class ChildrenLoadingState extends ChildrenState {}
//
// final class ChildrenSuccessState extends ChildrenState {
//   final List<ChildrenEntity> children;
//
//   ChildrenSuccessState({required this.children});
// }
//
// final class ChildrenFailureState extends ChildrenState {
//   final String errMessage;
//
//   ChildrenFailureState({required this.errMessage});
// }
//
// // -------------------- Create Child States --------------------
// final class CreateChildInitial extends ChildrenState {}
//
// final class CreateChildLoading extends ChildrenState {}
//
// final class CreateChildFailure extends ChildrenState {
//   final String errMessage;
//
//   CreateChildFailure({required this.errMessage});
// }
//
// final class CreateChildSuccess extends ChildrenState {}
//
// final class CreateChildOfflineSaved extends ChildrenState {
//   final String message;
//
//   CreateChildOfflineSaved(this.message);
// }
//
// // -------------------- Update Child States --------------------
// final class UpdateInitialState extends ChildrenState {}
//
// final class UpdateLoadingState extends ChildrenState {}
//
// final class UpdateSuccessState extends ChildrenState {}
//
// final class UpdateFailureState extends ChildrenState {
//   final String errMessage;
//
//   UpdateFailureState({required this.errMessage});
// }
//
// final class ChildrenOffLineState extends ChildrenState {
//   final String errMessage;
//
//   ChildrenOffLineState({required this.errMessage});
// }
//
// class ChildPagenationLoadingState extends ChildrenState{}
// final class ChildrenEmptyState extends ChildrenState {}
enum ChildrenStatus {
  initial,
  loading,
  success,
  failure,
  addSuccess,
  addFailure,
  addLoading,
  updateSuccess,
  updateFailure,
  updateLoading,
  searchLoading,
  offLineState,
  noResultSearch,
  empty,

}

class ChildrenState extends Equatable {
  final List<ChildrenEntity> allChildren;
  final String? errMessage;
  final bool isLoading;
  final int currentPage;
  final bool hasMore;
  final String searchQuery;
  final bool isSearching;
  final ChildrenStatus status;

  ChildrenState({
    this.errMessage,
    this.status = ChildrenStatus.initial,
    this.allChildren = const [],
    this.isLoading = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.searchQuery = '',
    this.isSearching = false,
  });

  ChildrenState copyWith({
    String? errMessage,
    List<ChildrenEntity>? allChildren,
    bool? isLoading,
    int? currentPage,
    bool? hasMore,
    String? searchQuery,
    bool? isSearching,
    ChildrenStatus? status,
  }) {
    return ChildrenState(
      errMessage: errMessage??this.errMessage,
      status: status ?? this.status,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      allChildren: allChildren ?? this.allChildren,
    );
  }

  @override
  List<Object?> get props => [
    allChildren,
    searchQuery,
    status,
    hasMore,
    isLoading,
    isSearching,
  ];
}
