part of 'bills_cubit.dart';

enum BillsStatus {
  initial,
  loading,
  success,
  failure,
  empty,
  createLoading,
  createSuccess,
  createFailure,
  activeLoading,
  activeSuccess,
  activeFailure,
  searchLoading,
  calculationsLoading,
  calculationsFailure,
  calculationsSuccess,
}

class BillsState extends Equatable {
  final FetchBillsParam filters;
  final BillsStatus status;
  final List<BillsEntity> bills;
  final String? errorMessage;
  final bool isSearching;
  final String searchQuery;
  final int currentPage;
  final bool hasMore;
  final bool isLoading;

  const BillsState({
    this.filters  = const FetchBillsParam(),
    this.status = BillsStatus.initial,
    this.bills = const [], // ✅統 واحد
    this.errorMessage,
    this.isSearching = false,
    this.searchQuery = '',
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoading = false,
  });

  BillsState copyWith({
    FetchBillsParam? filters,
    BillsStatus? status,
    List<BillsEntity>? bills,
    String? errorMessage,
    bool? isSearching,
    String? searchQuery,
    int? currentPage,
    bool? hasMore,
    bool? isLoading,
  }) {
    return BillsState(
      filters: filters ?? this.filters,
      status: status ?? this.status,
      bills: bills ?? this.bills,
      // ✅統 واحد
      errorMessage: errorMessage ?? this.errorMessage,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    filters,
    status,
    bills,
    errorMessage,
    isSearching,
    searchQuery,
    currentPage,
    hasMore,
    isLoading,
  ];
}
