
class AnalyticTypeModel {
  final String name;

  AnalyticTypeModel({required this.name});

  factory AnalyticTypeModel.fromJson(String json) {
    return AnalyticTypeModel(name: json);
  }
}