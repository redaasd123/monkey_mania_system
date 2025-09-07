class LayersModel {
  final String name;

  LayersModel({required this.name});

  factory LayersModel.fromJson(String json) {
    return LayersModel(name: json);
  }
}
