import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../../../main.dart';
import '../../../data/model/school_model.dart';
import '../../../domain/entity/school_entity.dart';
import '../../../domain/use_case/fetch_school_use_case.dart';

part 'school_state.dart';

class SchoolCubit extends Cubit<SchoolState> {
  SchoolCubit(this.schoolUseCase) : super(SchoolInitial());
  final FetchSchoolUseCase schoolUseCase;
  //search
  //

  List<SchoolEntity> allSchools = []; // الأصلية
  List<SchoolEntity> filteredSchools = [];
  //select
  SchoolEntity? selectedSchool;
  bool isSearch = false;

  Future<void> fetchSchool() async {
    emit(SchoolLoadingState());
    var result = await schoolUseCase.call();
    selectedSchool = null;
    result.fold(
      (failure) => emit(SchoolFailureState(errMessage: failure.errMessage)),

      (school) {
        allSchools = school;
        filteredSchools = school;
        emit(SchoolSuccessState(schools: school));
      },
    );
  }
  void searchSchools(String query) {
    if (query.isEmpty) {
      filteredSchools = allSchools;
      emit(SchoolSuccessState(schools: allSchools));
    } else {
      filteredSchools = allSchools.where((school) {
        return school.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(SchoolSearchResultState());
    }
  }

  void selectSchool(SchoolEntity school) {
    selectedSchool = school;
    isSearch = false;
    emit(SchoolSelectedState(selectedSchool: school));
    emit(SchoolSearchToggledState(isSearch: isSearch));
  }

  void toggleSearch(){
isSearch = !isSearch;
emit(SchoolSearchToggledState(isSearch: isSearch));

  }

  void canselSearch(){
    isSearch = false;
    selectedSchool=null;
    emit(SchoolSearchToggledState(isSearch: isSearch));
    fetchSchool();
  }



  void updateSchoolLocally(SchoolEntity updatedSchool) {
    // شيل المدرسة القديمة بنفس الـ id
    allSchools.removeWhere((school) => school.id == updatedSchool.id);
    filteredSchools.removeWhere((school) => school.id == updatedSchool.id);

    // ضيفها في آخر الليست (لأنك بتعرضهم في ListView من تحت لفوق)
    allSchools.add(updatedSchool);
    filteredSchools.add(updatedSchool);

    // حدث الواجهة
    emit(SchoolSuccessState(schools: filteredSchools));
  }



}
