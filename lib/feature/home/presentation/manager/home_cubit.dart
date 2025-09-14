import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';
import 'package:monkey_app/feature/home/domain/use_case/home_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeUseCase) : super(HomeState());
  final HomeUseCase homeUseCase;

  Future<void> fetchDashBoardData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await homeUseCase.call(NoParam());
    result.fold((failure) {
      print("❌ Failure: $failure");
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errMessage: failure.errMessage,
        ),
      );
    }, (data) => emit(state.copyWith(status: HomeStatus.success, data: data)));
  }
}
