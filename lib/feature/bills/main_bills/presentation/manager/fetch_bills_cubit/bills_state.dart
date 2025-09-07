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
  searchLoading
}

class BillsState extends Equatable {
  final BillsStatus status;
  final List<BillsEntity> bills; // ✅統 واحد
  final String? errorMessage;
  final bool isSearching;
  final String searchQuery;
  final int currentPage;
  final bool hasMore;
  final bool isLoading;

  const BillsState({
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
    BillsStatus? status,
    List<BillsEntity>? bills, // ✅統 واحد
    String? errorMessage,
    bool? isSearching,
    String? searchQuery,
    int? currentPage,
    bool? hasMore,
    bool? isLoading,
  }) {
    return BillsState(
      status: status ?? this.status,
      bills: bills ?? this.bills, // ✅統 واحد
      errorMessage: errorMessage ?? this.errorMessage,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [status, bills, errorMessage, isSearching, searchQuery, currentPage, hasMore, isLoading];
}

