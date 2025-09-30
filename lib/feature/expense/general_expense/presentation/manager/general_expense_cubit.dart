import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/create_general_expense_use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/general_expense_use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/update_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/update_general_expense_use_case.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../domain/entity/general_expense_item_entity.dart';

part 'general_expense_state.dart';

class GeneralExpenseCubit extends Cubit<GeneralExpenseState> {
  GeneralExpenseCubit({
    required this.updateGeneralExpenseUseCase,
    required this.generalExpenseUseCase,
    required this.createGeneralExpenseUseCase,
  }) : super(GeneralExpenseState());
  final GeneralExpenseUseCase generalExpenseUseCase;
  final CreateGeneralExpenseUseCase createGeneralExpenseUseCase;
  final UpdateGeneralExpenseUseCase updateGeneralExpenseUseCase;

  Future<void> fetchAllGeneralExpense(FetchBillsParam param) async {
    final currentPage = param.page ?? state.currentPage;
    if (state.isLoading) return;
    if (currentPage == 1) {
      emit(
        state.copyWith(isLoading: true, status: GeneralExpenseStatus.loading),
      );
    } else {
      emit(state.copyWith(status: GeneralExpenseStatus.pagenationLoading));
    }

    final result = await generalExpenseUseCase.call(param);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            status: GeneralExpenseStatus.failure,
            errMessage: failure.errMessage,
          ),
        );
      },
      (item) {
        if(item.results.isEmpty){
          emit(
            state.copyWith(
              isLoading: false,
              items: [],
              status: GeneralExpenseStatus.empty,
              hasMore: false,
            ),
          );
        }
        if (currentPage == 1 && item.results.isEmpty) {
          emit(
            state.copyWith(
              status: GeneralExpenseStatus.empty,
              isLoading: false,
              hasMore: false,
            ),
          );
          return;
        }


        final newItems = [
          ...(state.items ?? []),
          ...item.results,
        ];
        final uniqueItems = {
          for (var e in newItems) e.id: e
        }.values.toList().cast<GeneralExpenseItemEntity>(); // ← cast هنا

        emit(state.copyWith(
          status: GeneralExpenseStatus.success,
          items: uniqueItems,
          currentPage: (item.next?.isNotEmpty ?? false) ? currentPage + 1 : currentPage,
          isLoading: false,
          hasMore: item.next?.isNotEmpty ?? false,
        ));


      },
    );
  }

  Future<void> createGeneralExpense(CreateExpenseParam param) async {
    emit(state.copyWith(status: GeneralExpenseStatus.createLoading));
    var result = await createGeneralExpenseUseCase.call(param);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: GeneralExpenseStatus.createFailure,
            errMessage: failure.errMessage,
          ),
        );
      },
      (item) {
        final updateList = List<GeneralExpenseItemEntity>.from(
          state.items ?? [],
        )..insert(0, item);
        emit(
          state.copyWith(
            status: GeneralExpenseStatus.createSuccess,
            items: updateList,
          ),
        );
      },
    );
  }

  Future<void> updateGeneralExpense(UpdateExpenseParam param) async {
    emit(state.copyWith(status: GeneralExpenseStatus.updateLoading));
    var result = await updateGeneralExpenseUseCase.call(param);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: GeneralExpenseStatus.updateFailure,
            errMessage: failure.errMessage,
          ),
        );
      },
      (item) {
        final updateList = List<GeneralExpenseItemEntity>.from(
          state.items ?? [],
        );
        final index = updateList.indexWhere((child) => child.id == item.id);
        if (index != -1) {
          updateList[index] = item;
        } else {
          updateList..insert(0, item);
        }
        emit(
          state.copyWith(
            status: GeneralExpenseStatus.updateSuccess,
            items: updateList,
          ),
        );
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
  void searchBills(String query) {
    final trimmedQuery = query.trim();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: '',
          isSearching: false,
          currentPage: 1,
          hasMore: true,
          status: GeneralExpenseStatus.loading,
        ),
      );
      fetchAllGeneralExpense(FetchBillsParam(page: 1, query: null,branch: ['all']));
      return;
    }

    if (trimmedQuery.isNotEmpty && trimmedQuery.length >= 2) {
      emit(
        state.copyWith(
          filters: state.filters.copyWith(query: trimmedQuery),
          searchQuery: trimmedQuery,
          isSearching: true,
          items: [],
          currentPage: 1,
          hasMore: true,
          status: GeneralExpenseStatus.searchLoading,
        ),
      );
      fetchAllGeneralExpense(FetchBillsParam(page: 1, query: trimmedQuery,branch: ['all']));
    }
  }
  void setParam(FetchBillsParam param) {
    emit(state.copyWith(filters: param));
  }
}
