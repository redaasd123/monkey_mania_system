part of 'school_cubit.dart';

@immutable
// sealed class SchoolState {}
//
// final class SchoolInitial extends SchoolState {}
//
// final class SchoolLoadingState extends SchoolState {}
//
// final class SchoolFailureState extends SchoolState {
//   final String errMessage;
//
//   SchoolFailureState({required this.errMessage});
// }
//
// final class SchoolSuccessState extends SchoolState {
//   final List<SchoolEntity> schools;
//
//   SchoolSuccessState({required this.schools});
// }
//
// class SchoolSelectedState extends SchoolState {
//   final SchoolEntity selectedSchool;
//
//   SchoolSelectedState({required this.selectedSchool});
// }
//
// class SchoolSearchToggledState extends SchoolState {
//   final bool isSearch;
//
//   SchoolSearchToggledState({required this.isSearch});
// }
//
// final class SchoolSearchResultState extends SchoolState {}
//
// //////////////////update
//
// final class updateInitialState extends SchoolState {}
//
// final class UpdateLoadingState extends SchoolState {}
//
// final class UpdateSuccessState extends SchoolState {}
//
// final class UpdateFailureState extends SchoolState {
//   final String errMessage;
//
//   UpdateFailureState({required this.errMessage});
// }
//
// final class UpdateOfflineState extends SchoolState {
//   final String errMessage;
//
//   UpdateOfflineState({required this.errMessage});
// }
//
// final class CreateInitialState extends SchoolState {}
//
// final class CreateLoadingState extends SchoolState {}
//
// final class CreateSuccessState extends SchoolState {
//   CreateSuccessState();
// }
//
// final class CreateFailureState extends SchoolState {
//   final String errMessage;
//
//   CreateFailureState({required this.errMessage});
// }
//
// final class SchoolSearchLoadingState extends SchoolState {}
//
// final class CreateOfflineState extends SchoolState {
//   final String errMessage;
//
//   CreateOfflineState({required this.errMessage});
// }
enum SchoolStatus {
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
}

class SchoolState extends Equatable {
  final String? errMessage;
  final String searchQuery;
  final List<SchoolEntity> allSchool;
  final SchoolStatus status;
  final bool isSearching;

  const SchoolState({
    this.isSearching = false,
    this.status = SchoolStatus.initial,
    this.errMessage,
    this.searchQuery = '',
    this.allSchool = const [],
  });

  SchoolState copyWith({
    bool? isSearching,
    String? errMessage,
    String? searchQuery,
    List<SchoolEntity>? allSchool,
    SchoolStatus? status,
  }) {
    return SchoolState(
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      errMessage: errMessage ?? this.errMessage,
      allSchool: allSchool ?? this.allSchool,
    );
  }

  @override
  List<Object?> get props => [
    allSchool,
    status,
    searchQuery,
    errMessage,
    isSearching,
  ];
}
