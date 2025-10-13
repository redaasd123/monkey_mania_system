part of 'general_expense_cubit.dart';

enum GeneralExpenseStatus {
  createLoading,
  createFailure,
  createSuccess,
  updateLoading,
  updateFailure,
  updateSuccess,
  initial,
  loading,
  failure,
  success,
  hasMore,
  empty,
  pagenationLoading, searchLoading,
}

class GeneralExpenseState extends Equatable {
  final RequestParameters filters;
  final List<GeneralExpenseItemEntity>? items;
  final GeneralExpenseStatus status;
  final String? errMessage;
  final int currentPage;
  final bool isLoading;
  final bool hasMore;
  final bool isSearching;
  final String searchQuery;

  /////////////create

  const GeneralExpenseState({
    this.filters = const RequestParameters(),
    this.searchQuery = '',
    this.isSearching = false,
    this.hasMore = true,
    this.items,
    this.status = GeneralExpenseStatus.initial,
    this.errMessage,
    this.currentPage = 1,
    this.isLoading = false,
  });

  GeneralExpenseState copyWith({
    RequestParameters? filters,
    String? searchQuery,
    bool? isSearching,
    List<GeneralExpenseItemEntity>? items,
    GeneralExpenseStatus? status,
    String? errMessage,
    int? currentPage,
    bool? isLoading,
    bool? hasMore,
  }) {
    return GeneralExpenseState(
      filters: filters??this.filters,
      searchQuery: searchQuery??this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      items: items ?? this.items,
      status: status ?? this.status,
      errMessage: errMessage ?? this.errMessage,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
    filters,
    searchQuery,
    items,
    status,
    errMessage,
    currentPage,
    isLoading,
    hasMore,
    isSearching
  ];
}
