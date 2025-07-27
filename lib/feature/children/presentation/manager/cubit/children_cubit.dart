import 'package:bloc/bloc.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/domain/children_use_case/fetch_children_use_case.dart';

import '../../../domain/entity/children/children_entity.dart';

part 'children_state.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  final FetchChildrenUseCase fetchChildrenUseCase;
   List<ChildrenEntity> allChildren = [];
   List<ChildrenEntity> filterChildren = [];
  ChildrenEntity? selectChild;
  bool isSearching = false;

  ChildrenCubit(this.fetchChildrenUseCase) : super(ChildrenInitial());

  Future<void> fetchChildren() async {
    print("📢 fetchChildren STARTED");
    emit(ChildrenLoadingState());
    print("🔴 emitted Loading");

    final result = await fetchChildrenUseCase.call(NoParam());
    selectChild = null;

    result.fold(
          (failure) {
        if (!isClosed)
          emit(ChildrenFailureState(errMessage: failure.errMessage));
      },
          (children) {
        allChildren = children;
        filterChildren = children;

        if (!isClosed) emit(ChildrenSuccessState(children: children));
      },
    );
  }


  void searchChild(String query) {
    if (query.isEmpty) {
      filterChildren = allChildren;
      emit(ChildrenSuccessState(children: allChildren));
    } else {
      filterChildren = allChildren.where((child) {
        return child.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(ChildrenSearchResultState());
    }
  }

  void selectChildren(ChildrenEntity children) {
    selectChild = children;
    isSearching = false;
    emit(ChildrenSelectedState(selectChildren: children));
    emit(ChildrenToggleState(isSearch: isSearching));
  }

  void toggleChildren(){
    isSearching = !isSearching;
    emit(ChildrenToggleState(isSearch: isSearching));
  }
  void closeSearch(){
    isSearching = false;
    emit(ChildrenToggleState(isSearch: isSearching));
    fetchChildren();
  }







}
