part of 'bills_cubit.dart';

// enum BillsStatus {
//   initial,
//   loading,
//   success,
//   failure,
//   empty,
//   createLoading,
//   createSuccess,
//   createFailure,
//   activeLoading,
//   activeSuccess,
//   activeFailure,
// }
//
//
// class BillsState extends Equatable {
//   final BillsStatus status;          // الحالة الحالية
//   final List<BillsEntity> bills;     // البيانات المعروضة
//   final String? errorMessage;        // رسالة الخطأ
//   final bool isSearching;            // هل البحث مفعّل
//   final String searchQuery;          // نص البحث الحالي
//   final int currentPage;             // رقم الصفحة
//   final bool hasMore;
//   final bool isLoading;
//
//   const BillsState({
//     this.status = BillsStatus.initial,
//     this.bills = const [],
//     this.errorMessage,
//     this.isSearching = false,
//     this.searchQuery = '',
//     this.currentPage = 1,
//     this.hasMore = true,
//     this.isLoading = false,
//   });
//
//   BillsState copyWith({
//     BillsStatus? status,
//     List<BillsEntity>? bills,
//     String? errorMessage,
//     bool? isSearching,
//     String? searchQuery,
//     int? currentPage,
//     bool? hasMore,
//     bool? isLoading,
//   }) {
//     return BillsState(
//       status: status ?? this.status,
//       bills: bills ?? this.bills,
//       errorMessage: errorMessage ?? this.errorMessage,
//       isSearching: isSearching ?? this.isSearching,
//       searchQuery: searchQuery ?? this.searchQuery,
//       currentPage: currentPage ?? this.currentPage,
//       hasMore: hasMore ?? this.hasMore,
//       isLoading: isLoading??this.isLoading,
//     );
//   }
//
//   @override
//   List<Object?> get props =>
//       [status, bills, errorMessage, isSearching, searchQuery, currentPage, hasMore];
// }


@immutable
abstract class BillsState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// 🔵 Initial
class BillsInitial extends BillsState {}

/// 🔵 Loading
class BillsLoadingState extends BillsState {} // شاشة كاملة تحميل

/// 🔵 Success
class BillsSuccessState extends BillsState {
  final List<BillsEntity> bills;

  BillsSuccessState({required this.bills});

  @override
  List<Object?> get props => [bills];
}

/// 🔵 Failure
class BillsFailureState extends BillsState {
  final String errMessage;

  BillsFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

/// 🔵 Empty / NoMore
class BillsEmptyState extends BillsState {}

class BillsNoMoreDataState extends BillsState {}

/// 🔵 Search
class BillsSearchToggledState extends BillsState {
  final bool isSearching;

  BillsSearchToggledState({required this.isSearching});

  @override
  List<Object?> get props => [isSearching];
}

/// 🔵 Active Bills
class FetchActiveBillsLoadingState extends BillsState {}

class FetchActiveBillsSuccessState extends BillsState {
  final List<BillsEntity> bills;

  FetchActiveBillsSuccessState({required this.bills});

  @override
  List<Object?> get props => [bills];
}

class FetchActiveBillsFailureState extends BillsState {
  final String errMessage;

  FetchActiveBillsFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

/// 🔵 Create Bills
class CreateBillsLoadingState extends BillsState {}

class CreateBillsSuccessState extends BillsState {}

class CreateBillsFailureState extends BillsState {
  final List<BillsEntity> bills;
  final String errMessage;

  CreateBillsFailureState({required this.errMessage, required this.bills});

  @override
  List<Object?> get props => [errMessage];
}
