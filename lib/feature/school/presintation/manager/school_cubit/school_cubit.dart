import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/utils/constans.dart';

import '../../../../../core/errors/off_line_failure.dart';
import '../../../../../core/param/create_school_param/create_school_param.dart';
import '../../../../../core/param/update_school_param/update_school_param.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../domain/entity/school_entity.dart';
import '../../../domain/use_case/fetch_school_use_case.dart';
import '../../../domain/use_case/post_school_use_case.dart';
import '../../../domain/use_case/update_school_use_case.dart';

part 'school_state.dart';

class SchoolCubit extends Cubit<SchoolState> {
  SchoolCubit(
    this.schoolUseCase,
    this.postSchoolUseCase,
    this.updateSchoolUseCase,
  ) : super(SchoolState());
  final FetchSchoolUseCase schoolUseCase;
  final PostSchoolUseCase postSchoolUseCase;
  final UpdateSchoolUseCase updateSchoolUseCase;

  Future<void> fetchSchool([String query = '']) async {
    if (query.isNotEmpty) {
      emit(state.copyWith(status: SchoolStatus.searchLoading));
    } else {
      emit(state.copyWith(status: SchoolStatus.loading));
    }

    var result = await schoolUseCase.call(query);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SchoolStatus.failure,
          errMessage: failure.errMessage,
        ),
      ),

      (school) {
        if (school.isEmpty) {
          emit(
            state.copyWith(
              status: SchoolStatus.noResultSearch,
              allSchool: school,
            ),
          );
        } else {
          emit(state.copyWith(status: SchoolStatus.success, allSchool: school));
        }
      },
    );
  }

  Future<void> updateSchool(UpdateSchoolParam param) async {
    if (isClosed) return;
    emit(state.copyWith(status: SchoolStatus.updateLoading));

    final result = await updateSchoolUseCase.call(param);

    if (isClosed) return;
    result.fold(
      (failure) {
        if (state is OfflineFailure) {
          emit(
            state.copyWith(
              status: SchoolStatus.offLineState,
              errMessage: LangKeys.messageFailureOffLine.tr(),
            ),
          );
        } else {
          if (!isClosed)
            emit(
              state.copyWith(
                status: SchoolStatus.updateFailure,
                errMessage: failure.errMessage,
              ),
            );
        }
      },
      (success) {
        final updatedList = List<SchoolEntity>.from(state.allSchool);
        final index = updatedList.indexWhere(
          (school) => school.id == success.id,
        );
        if (index != -1) {
          updatedList[index] = success;
        } else {
          updatedList..insert(0, success);
        }
        emit(
          state.copyWith(
            status: SchoolStatus.updateSuccess,
            allSchool: updatedList,
          ),
        );
      },
    );
  }

  Future<void> createSchool(CreateSchoolParam param) async {
    emit(state.copyWith(status: SchoolStatus.addLoading));
    var result = await postSchoolUseCase.call(param);
    result.fold(
      (failure) {
        if (state is OfflineFailure) {
          emit(
            state.copyWith(
              status: SchoolStatus.offLineState,
              errMessage: LangKeys.messageFailureOffLine.tr(),
            ),
          );
        } else {
          if (!isClosed)
            emit(
              state.copyWith(
                status: SchoolStatus.addFailure,
                errMessage: failure.errMessage,
              ),
            );
        }
      },
      (success) {
        final updatedList = List<SchoolEntity>.from(state.allSchool)
          ..insert(0, success);
        emit(
          state.copyWith(
            status: SchoolStatus.addSuccess,
            allSchool: updatedList,
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

  void searchSchool(String query) {
    emit(
      state.copyWith(
        searchQuery: query,
        status: SchoolStatus.success,
        allSchool: state.allSchool,
      ),
    );
    fetchSchool(query);
  }
}
