import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/get_all_layers_use_case.dart';
import '../../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../domain/use_case/get_layer_one.dart';
import '../../../domain/use_case/get_layer_tow.dart';

part 'layers_state.dart';

class LayersCubit extends Cubit<LayersState> {
  LayersCubit(this.layerOne, this.layerTow, this.allLayersUseCase)
      : super(const LayersState());

  final GetLayerOneUseCase layerOne;
  final GetLayerTowUseCase layerTow;
  final GetAllLayersUseCase allLayersUseCase;

  Future<void> getLayerOne(RequestParameters param) async {
    emit(state.copyWith(status: LayersStatus.getLayerOneLoading));

    var result = await layerOne.call(param);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            status: LayersStatus.getLayerOneFailure,
            errMessage: failure.errMessage,
          ),
        );
      },
          (category) {
        emit(
          state.copyWith(
            cashedLayerOne: category,
            status: LayersStatus.getLayerOneSuccess,
            layer1: category,
          ),
        );
      },
    );
  }

  Future<void> getLayerTow(RequestParameters param) async {
    emit(state.copyWith(status: LayersStatus.getLayerTowLoading));

    var result = await layerTow.call(param);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            status: LayersStatus.getLayerTowFailure,
            errMessage: failure.errMessage,
          ),
        );
      },
          (category) {
        emit(
          state.copyWith(
            cashedLayerTow: category,
            status: LayersStatus.getLayerTowSuccess,
            layer2: category,
            selectedLayer1: param.layer1,
          ),
        );
      },
    );
  }

  Future<void> getAllLayer(RequestParameters param) async {
    emit(state.copyWith(status: LayersStatus.layer3Loading));

    var result = await allLayersUseCase.call(param);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            status: LayersStatus.layer3Failure,
            errMessage: failure.errMessage,
          ),
        );
      },
          (allLayers) {
        emit(
          state.copyWith(
            status: LayersStatus.layer3Success,
            layer3: allLayers,
            selectedLayer2: param.layer2,
            cashedLayerOne: null,
            cashedLayerTow: null,
          ),
        );
      },
    );
  }

  Future<void> getLayerOneCashed() async {
    if (state.cashedLayerOne.isNotEmpty) {
      emit(
        state.copyWith(
          status: LayersStatus.cashedLayerOne,
          layer1: state.cashedLayerOne,
          selectedLayer1: state.selectedLayer1,
          selectedLayer2: state.selectedLayer2,
        ),
      );
    }
  }

  Future<void> getLayerOTowCashed() async {
    if (state.cashedLayerTow.isNotEmpty) {
      emit(
        state.copyWith(
          status: LayersStatus.cashedLayerTow,
          layer2: state.cashedLayerTow,
          selectedLayer1: state.selectedLayer1,
          selectedLayer2: state.selectedLayer2,
        ),
      );
    }
  }
}
