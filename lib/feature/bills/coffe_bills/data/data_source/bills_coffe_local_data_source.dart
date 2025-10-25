import 'package:hive/hive.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/hive_entity/layers_hive_entity.dart';

abstract class BillsCoffeeLocalDataSource {
  Future<List<LayersHiveEntity>> fetchLayers();
}

class BillsCoffeeLocalDataSourceImpl extends BillsCoffeeLocalDataSource {
  @override
  Future<List<LayersHiveEntity>> fetchLayers() async {
    return Hive.box<LayersHiveEntity>(kSaveLayerOne).values.toList();
  }
}
