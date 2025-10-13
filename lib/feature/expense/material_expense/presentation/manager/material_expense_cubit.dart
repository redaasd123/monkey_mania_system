import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/materials.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/create_material_expense_use_case.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/material_expense_use_case.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/materials_use_case.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/use_case/update_material_expense_use_case.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../general_expense/domain/use_case/param/create_param.dart';
import '../../../general_expense/domain/use_case/param/update_param.dart';

part 'material_expense_state.dart';

class MaterialExpenseCubit extends Cubit<MaterialExpenseState> {
  MaterialExpenseCubit({
    required this.materialsUseCase,
    required this.materialExpenseUseCase,
    required this.createMaterialExpenseUseCase,
    required this.updateMaterialExpenseUseCase,
  }) : super(MaterialExpenseState());

  final MaterialExpenseUseCase materialExpenseUseCase;
  final CreateMaterialExpenseUseCase createMaterialExpenseUseCase;
  final UpdateMaterialExpenseUseCase updateMaterialExpenseUseCase;
  final MaterialsUseCase materialsUseCase;

  Future<void> fetchAllMaterialExpense(RequestParameters param) async {
    final currentPage = param.page ?? state.currentPage;
    if (state.isLoading) return;
    if (currentPage == 1) {
      emit(
        state.copyWith(isLoading: true, status: MaterialExpenseStatus.loading),
      );
    } else {
      emit(state.copyWith(status: MaterialExpenseStatus.pagenationLoading));
    }

    final result = await materialExpenseUseCase.call(param);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            status: MaterialExpenseStatus.failure,
            errMessage: failure.errMessage,
          ),
        );
      },
      (item) {
        if (item.results.isEmpty) {
          emit(
            state.copyWith(
              isLoading: false,
              items: [],
              status: MaterialExpenseStatus.empty,
              hasMore: false,
            ),
          );
        }
        if (currentPage == 1 && item.results.isEmpty) {
          emit(
            state.copyWith(
              status: MaterialExpenseStatus.empty,
              isLoading: false,
              hasMore: false,
            ),
          );
          return;
        }

        final newItems = [...(state.items ?? []), ...item.results];
        final uniqueItems = {
          for (var e in newItems) e.id: e,
        }.values.toList().cast<MaterialExpenseItemEntity>(); // ← cast هنا

        emit(
          state.copyWith(
            status: MaterialExpenseStatus.success,
            items: uniqueItems,
            currentPage: (item.next?.isNotEmpty ?? false)
                ? currentPage + 1
                : currentPage,
            isLoading: false,
            hasMore: item.next?.isNotEmpty ?? false,
          ),
        );
      },
    );
  }

  Future<void> createMaterialExpense(CreateExpenseParam param) async {
    emit(state.copyWith(status: MaterialExpenseStatus.createLoading));
    var result = await createMaterialExpenseUseCase.call(param);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: MaterialExpenseStatus.createFailure,
            errMessage: failure.errMessage,
          ),
        );
      },
      (item) {
        final updateList = List<MaterialExpenseItemEntity>.from(
          state.items ?? [],
        )..insert(0, item);
        emit(
          state.copyWith(
            status: MaterialExpenseStatus.createSuccess,
            items: updateList,
          ),
        );
      },
    );
  }

  Future<void> updateMaterialExpense(UpdateExpenseParam param) async {
    emit(state.copyWith(status: MaterialExpenseStatus.updateLoading));
    var result = await updateMaterialExpenseUseCase.call(param);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: MaterialExpenseStatus.updateFailure,
            errMessage: failure.errMessage,
          ),
        );
      },
      (item) {
        final updateList = List<MaterialExpenseItemEntity>.from(
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
            status: MaterialExpenseStatus.updateSuccess,
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
          status: MaterialExpenseStatus.loading,
        ),
      );
      fetchAllMaterialExpense(RequestParameters(page: 1, query: null,branch: ['all']));
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
          status: MaterialExpenseStatus.searchLoading,
        ),
      );
      fetchAllMaterialExpense(RequestParameters(page: 1, query: trimmedQuery,branch: ['all']));
    }
  }

  Future<void> fetchMaterials(RequestParameters param)async{
    emit(state.copyWith(status: MaterialExpenseStatus.materialsLoading));
    final result = await materialsUseCase.call(param);
    result.fold((failure){

      emit(
        state.copyWith(
          status: MaterialExpenseStatus.materialsFailure,
          errMessage: failure.errMessage,
        ),
      );
    }, (materials){
      emit(
        state.copyWith(
          status: MaterialExpenseStatus.materialsSuccess,
          materials: materials,
        ),
      );
    });
  }
  void setParam(RequestParameters param){
    emit(state.copyWith(filters: param));
  }
}
