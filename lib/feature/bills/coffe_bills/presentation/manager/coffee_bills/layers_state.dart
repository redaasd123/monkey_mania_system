part of 'layers_cubit.dart';

enum LayersStatus {
  initial,
  getLayerOneLoading,
  getLayerOneSuccess,
  getLayerOneFailure,
  getLayerTowLoading,
  getLayerTowSuccess,
  getLayerTowFailure,
  layer3Success,
  layer3Failure,
  layer3Loading,
  cashedLayerTow,
  cashedLayerOne,
}

class LayersState extends Equatable {
  final List<LayersEntity> cashedLayerOne;
  final List<LayersEntity> cashedLayerTow;
  final LayersStatus status;
  final String? errMessage;
  final List<LayersEntity> layer1;
  final List<GetAllLayerEntity> layer3;
  final List<LayersEntity> layer2;

  // 🟢 متغيرات لحفظ الاختيارات
  final String? selectedLayer1;
  final String? selectedLayer2;

  const LayersState({
    this.layer3 = const [],
    this.cashedLayerOne = const [],
    this.cashedLayerTow = const [],
    this.status = LayersStatus.initial,
    this.errMessage,
    this.layer1 = const [],
    this.layer2 = const [],
    this.selectedLayer1,
    this.selectedLayer2,
  });

  LayersState copyWith({
    List<GetAllLayerEntity>? layer3,
    List<LayersEntity>? cashedLayerOne,
    List<LayersEntity>? cashedLayerTow,
    LayersStatus? status,
    String? errMessage,
    List<LayersEntity>? layer1,
    List<LayersEntity>? layer2,
    String? selectedLayer1,
    String? selectedLayer2,
  }) {
    return LayersState(
      cashedLayerTow: cashedLayerTow ?? this.cashedLayerTow,
      layer3: layer3 ?? this.layer3,
      cashedLayerOne: cashedLayerOne ?? this.cashedLayerOne,
      status: status ?? this.status,
      errMessage: errMessage ?? this.errMessage,
      layer1: layer1 ?? this.layer1,
      layer2: layer2 ?? this.layer2,
      selectedLayer1: selectedLayer1 ?? this.selectedLayer1,
      selectedLayer2: selectedLayer2 ?? this.selectedLayer2,
    );
  }

  @override
  List<Object?> get props => [
    cashedLayerTow,
    status,
    errMessage,
    layer1,
    cashedLayerOne,
    layer3,
    layer2,
    selectedLayer1, // 🟢 أضفناها للمقارنة
    selectedLayer2, // 🟢 أضفناها للمقارنة
  ];
}
