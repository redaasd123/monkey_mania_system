import 'package:equatable/equatable.dart';
import '../../../domain/entity/children/children_entity.dart';

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
