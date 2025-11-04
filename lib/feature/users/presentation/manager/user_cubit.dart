import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/create_user_param.dart';
import 'package:monkey_app/feature/users/domain/repo/update_user_param.dart';
import 'package:monkey_app/feature/users/domain/use_case/create_user_use_case.dart';
import 'package:monkey_app/feature/users/domain/use_case/fetch_user_use_case.dart';
import 'package:monkey_app/feature/users/domain/use_case/update_user_use_case.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(
    this.fetchUserUseCase,
    this.createUserUseCase,
    this.updateUserUseCase,
  ) : super(UserState());
  final FetchUserUseCase fetchUserUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  Future<void> fetchUsers(RequestParameters param) async {
    if (state.isLoading ) return;

    final pageNumber = param.page ?? state.currentPage;

    emit(
      state.copyWith(
        isLoading: true,
        status: pageNumber == 1 ? UserStatus.loading : state.status,
      ),
    );

    final result = await fetchUserUseCase.call(param);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            data: [],
            status: UserStatus.failure,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (userPage) {
        if (userPage.userData.isEmpty && pageNumber == 1) {
          emit(
            state.copyWith(
              isLoading: false,
              status: UserStatus.empty,
              hasMore: false,
            ),
          );
          return;
        }

        final updatedBills = pageNumber == 1
            ? userPage.userData
            : [...state.data!, ...userPage.userData];

        final more = userPage.next != null;

        emit(
          state.copyWith(
            isLoading: false,
            data: updatedBills,
            userDataForFireBase: List<UserDataEntity>.from(updatedBills),
            hasMore: more,
            currentPage: more ? pageNumber + 1 : pageNumber,
            status: UserStatus.success,
          ),
        );
      },
    );
  }

  Future<void> createUser(CreateUserParam param) async {
    emit(state.copyWith(status: UserStatus.addLoading));
    final result = await createUserUseCase.call(param);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: UserStatus.addFailure,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (success) {
        final updateList = List<UserDataEntity>.from(state.data as Iterable)
          ..insert(0, success);
        emit(state.copyWith(status: UserStatus.addSuccess, data: updateList));
      },
    );
  }
  Future<void> updateUser(UpdateUserParam param)async{
    emit(state.copyWith(status: UserStatus.updateLoading));
    final result = await updateUserUseCase.call(param);
    result.fold(
          (failure) {
        emit(
          state.copyWith(
            status: UserStatus.updateFailure,
            errorMessage: failure.errMessage,
          ),
        );
      },
          (success) {
        final updateList = List<UserDataEntity>.from(state.data as Iterable);
        final index = updateList.indexWhere((child)=>child.id==success.id);
        if(index!=-1){
                    updateList[index]=success;
                  }else{
                    updateList..insert(0, success);
                  }
        emit(state.copyWith(status: UserStatus.updateSuccess, data: updateList));
      },
    );
  }



  void toggleSearch() {
    if (state.isSearching) {
      emit(state.copyWith(isSearching: false, searchQuery: ''));
    } else {
      emit(state.copyWith(isSearching: true));
    }
  }
  Future<void> onRefresh() async {
    emit(
      state.copyWith(
        searchQuery: '',
        status: UserStatus.loading,
        currentPage: 1,
        hasMore: true,
        data: [],
      ),
    );

    await fetchUsers(RequestParameters(page: 1, branch: ['all']));



  }
  void searchUsers(String query) {
    final trimmedQuery = query.trim();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: '',
          isSearching: false,
          currentPage: 1,
          hasMore: true,
          status: UserStatus.loading,
        ),
      );
      fetchUsers(RequestParameters(page: 1, query: null, branch: ['all']));
      return;
    }

    if (trimmedQuery.isNotEmpty && trimmedQuery.length >= 2) {
      emit(
        state.copyWith(
          searchQuery: trimmedQuery,
          isSearching: true,
          data: [],
          currentPage: 1,
          hasMore: true,
          status: UserStatus.searchLoading,
        ),
      );
      fetchUsers(
        RequestParameters(page: 1, query: trimmedQuery, branch: ['all']),
      );
    }
  }
}
