part of 'material_expense_cubit.dart';

enum MaterialExpenseStatus {
  createLoading,
  createFailure,
  createSuccess,
  updateLoading,
  updateFailure,
  updateSuccess,
  materialsLoading,
  materialsFailure,
  materialsSuccess,
  initial,
  loading,
  failure,
  success,
  hasMore,
  empty,
  pagenationLoading, searchLoading,
}

class MaterialExpenseState extends Equatable {
  final List<MaterialExpenseItemEntity>? items;
  final List<MaterialsEntity>? materials;
  final MaterialExpenseStatus status;
  final String? errMessage;
  final int currentPage;
  final bool isLoading;
  final bool hasMore;
  final bool isSearching;
  final String searchQuery;

  /////////////create

  const MaterialExpenseState({
    this.materials,
    this.searchQuery = '',
    this.isSearching = false,
    this.hasMore = true,
    this.items,
    this.status = MaterialExpenseStatus.initial,
    this.errMessage,
    this.currentPage = 1,
    this.isLoading = false,
  });

  MaterialExpenseState copyWith({
    String? searchQuery,
    bool? isSearching,
    List<MaterialsEntity>? materials,
    List<MaterialExpenseItemEntity>? items,
    MaterialExpenseStatus? status,
    String? errMessage,
    int? currentPage,
    bool? isLoading,
    bool? hasMore,
  }) {
    return MaterialExpenseState(
      materials: this.materials??materials,
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
    materials,
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
