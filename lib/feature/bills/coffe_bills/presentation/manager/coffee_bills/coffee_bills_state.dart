 part of 'coffee_bills_cubit.dart';




 enum CoffeeBillsStatus {
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
 }
 class BillsCoffeeState extends Equatable {
   final FetchBillsParam filters;
   final CoffeeBillsStatus status;
   final List<BillsCoffeeEntity> bills;
   final String? errorMessage;
   final bool isSearching;
   final String searchQuery;
   final int currentPage;
   final bool hasMore;
   final bool isLoading;

   const BillsCoffeeState({
     this.filters = const FetchBillsParam(),
     this.status = CoffeeBillsStatus.initial,
     this.bills = const [], // ✅統 واحد
     this.errorMessage,
     this.isSearching = false,
     this.searchQuery = '',
     this.currentPage = 1,
     this.hasMore = true,
     this.isLoading = false,
   });

   BillsCoffeeState copyWith({
     FetchBillsParam? filters,
     GetOneBillsCoffeeEntity? getOneBills,
     CoffeeBillsStatus? status,
     List<BillsCoffeeEntity>? bills,
     String? errorMessage,
     bool? isSearching,
     String? searchQuery,
     int? currentPage,
     bool? hasMore,
     bool? isLoading,
   }) {
     return BillsCoffeeState(
       filters: filters??this.filters,
       status: status ?? this.status,
       bills: bills ?? this.bills,
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
       [status, bills, errorMessage, isSearching, searchQuery, currentPage, hasMore, isLoading,filters,
       ];
 }








