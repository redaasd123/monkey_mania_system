part of 'user_cubit.dart';

enum UserStatus {
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
  noResultSearch,
  empty,
}

class UserState extends Equatable {
  final UserStatus status;
  final List<UserDataEntity>? data;
  final List<UserDataEntity>? userDataForFireBase;
  final String? errorMessage;
  final bool isSearching;
  final String searchQuery;
  final int currentPage;
  final bool hasMore;
  final bool isLoading;

  const UserState({
    this.userDataForFireBase,
    this.data,
    this.status = UserStatus.initial,
    this.errorMessage,
    this.isSearching = false,
    this.searchQuery = '',
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoading = false,
  });

  UserState copyWith({
    UserStatus? status,
    List<UserDataEntity>? data,
    List<UserDataEntity>? userDataForFireBase,
    String? errorMessage,
    bool? isSearching,
    String? searchQuery,
    int? currentPage,
    bool? hasMore,
    bool? isLoading,
  }) {
    return UserState(
      userDataForFireBase: userDataForFireBase??this.userDataForFireBase,
      status: status ?? this.status,
      data: data ?? this.data,
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
    userDataForFireBase,
    status,
    data,
    errorMessage,
    isSearching,
    searchQuery,
    currentPage,
    hasMore,
    isLoading,
  ];
}
