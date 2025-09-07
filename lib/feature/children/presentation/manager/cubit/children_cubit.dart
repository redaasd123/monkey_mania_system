import 'package:bloc/bloc.dart';

import '../../../../../core/errors/off_line_failure.dart';
import '../../../../../core/param/create_children_params/create_children_params.dart';
import '../../../../../core/param/update_children_param/update_children_param.dart';
import '../../../domain/children_use_case/create_chil_use_case.dart';
import '../../../domain/children_use_case/fetch_children_use_case.dart';
import '../../../domain/children_use_case/update_children_use_case.dart';
import '../../../domain/entity/children/children_entity.dart';
import '../../../domain/param/fetch_children_param.dart';
import 'children_state.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  final FetchChildrenUseCase fetchChildrenUseCase;
  final CreateChildUseCase createChildUseCase;
  final UpdateChildrenUseCase updateChildrenUseCase;

  ChildrenCubit({
    required this.fetchChildrenUseCase,
    required this.createChildUseCase,
    required this.updateChildrenUseCase,
  }) : super(ChildrenState());

  // ---------------- FETCH ----------------
  Future<void> fetchChildren(FetchChildrenParam param) async {
    if (state.isLoading || !state.hasMore) return;

    final pageNumber = param.pageNumber ?? state.currentPage;

    // تحديث حالة التحميل
    emit(
      state.copyWith(
        isLoading: true,
        status: pageNumber == 1 ? ChildrenStatus.loading : state.status,
        currentPage: pageNumber,
      ),
    );

    final result = await fetchChildrenUseCase.call(param);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            status: ChildrenStatus.failure,
            errMessage: failure.errMessage,
          ),
        );
      },
      (childrenData) {
        // لو الصفحة الأولى وفاضية
        if (childrenData.children.isEmpty && pageNumber == 1) {
          emit(
            state.copyWith(
              isLoading: false,
              status: ChildrenStatus.empty,
              allChildren: [],
              hasMore: false,
            ),
          );
          return;
        }

        // دمج البيانات الجديدة مع القديمة
        final updatedList = pageNumber == 1
            ? childrenData.children
            : [...state.allChildren, ...childrenData.children];

        // هل يوجد صفحات لاحقة
        final more = childrenData.nextPage != null;

        emit(
          state.copyWith(
            isLoading: false,
            status: ChildrenStatus.success,
            allChildren: updatedList,
            hasMore: more,
            currentPage: more ? pageNumber + 1 : pageNumber,
          ),
        );
      },
    );
  }

  // ---------------- SEARCH ----------------
  void toggleSearch() {
    if (state.isSearching) {
      emit(state.copyWith(isSearching: false, searchQuery: ''));
    } else {
      emit(state.copyWith(isSearching: true));
    }
  }

  void searchChildren(String query) {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: "",
          status: ChildrenStatus.success,
          currentPage: 1,
          hasMore: true,
        ),
      );
      fetchChildren(FetchChildrenParam(pageNumber: 1));
      return;
    }

    if (trimmedQuery.length >= 2) {
      emit(
        state.copyWith(
          searchQuery: trimmedQuery,
          isSearching: true,
          status: ChildrenStatus.searchLoading,
          currentPage: 1,
          hasMore: true,
        ),
      );
      fetchChildren(FetchChildrenParam(query: trimmedQuery, pageNumber: 1));
    }
  }

  // ---------------- CREATE ----------------
  Future<void> createChildren(CreateChildrenParam param) async {
    emit(state.copyWith(status: ChildrenStatus.addLoading));

    final result = await createChildUseCase.call(param);

    result.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(
            state.copyWith(
              status: ChildrenStatus.offLineState,
              errMessage:
                  'لم يتوفر اتصال بالانترنت وتم الحفظ مؤقتا وسيتم الارسال عند توفر الاتصال.',
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ChildrenStatus.addFailure,
              errMessage: failure.errMessage,
            ),
          );
        }
      },
      (success) {
        final updateList = List<ChildrenEntity>.from(state.allChildren)
          ..insert(0, success);
        emit(
          state.copyWith(
            status: ChildrenStatus.addSuccess,
            allChildren: updateList,
          ),
        );
      },
    );
  }

  // ---------------- UPDATE ----------------
  Future<void> updateChildren(UpdateChildrenParam param) async {
    emit(state.copyWith(status: ChildrenStatus.updateLoading));

    final result = await updateChildrenUseCase.call(param);

    result.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(
            state.copyWith(
              status: ChildrenStatus.offLineState,
              errMessage:
                  'لم يتوفر اتصال بالانترنت وتم الحفظ مؤقتا وسيتم الارسال عند توفر الاتصال.',
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ChildrenStatus.updateFailure,
              errMessage: failure.errMessage,
            ),
          );
        }
      },
      (success) {
        final updateList = List<ChildrenEntity>.from(state.allChildren)
          ..insert(0, success);
        emit(
          state.copyWith(
            status: ChildrenStatus.updateSuccess,
            allChildren: updateList,
          ),
        );
      },
    );
  }
}
