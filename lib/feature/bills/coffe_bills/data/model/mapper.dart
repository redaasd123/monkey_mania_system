import 'package:monkey_app/feature/bills/coffe_bills/data/model/bills_coffee_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_all_layers_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_layer1_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/get_one_coffee_bills_model.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';

extension GetCoffeeBillMapper on BillsCoffeeModel {
  BillsCoffeeEntity toEntity() {
    return BillsCoffeeEntity(
      id: id ?? 1,
      takeAway: takeAway ?? false,
      totalPrice: totalPrice ?? 0,
      tableNumber: tableNumber ?? 0,
      billNumber: billNumber ?? 0,

    );
  }
}

extension GetOneCoffeeBillMapper on GetOneCoffeeBillsModel {
  GetOneBillsCoffeeEntity toEntity() {
    return GetOneBillsCoffeeEntity(
      id: id ?? 1,
      billNumber: billNumber ?? 1,
      tableNumber: tableNumber ?? 1,
      totalPrice: double.tryParse(totalPrice ?? '0') ?? 0,
      takeAway: takeAway ?? false,
      products: products?.map((p) => p.toEntity()).toList() ?? [],
      returnedProducts: returnedProducts ?? [],
      createdBy: createdBy ?? '',
      created: created ?? '',
      updated: updated ?? '',
      createdById: createdById ?? 0,
    );
  }
}

extension GetOneProductBillMapper on GetOneProducts {
  Product toEntity() {
    return Product(
      unitPrice: unitPrice ?? '',
      totalPrice: totalPrice ?? 0,
      quantity: quantity ?? 0,
      notes: notes ?? '',
      name: name ?? '',
    );
  }
}

extension GetLayers on LayersModel {
  LayersEntity toEntity() {
    return LayersEntity(name: name);
  }
}

/////////////////////////////////////getAllLayers

extension GetAllLayers on GetAllLayersModel {
  GetAllLayerEntity toEntity() {
    return GetAllLayerEntity(
      id: id ?? 1,
      layer1: layer1 ?? "",
      layer2: layer2 ?? "",
      layer3: layer3 ?? "",
      product: product ?? "",
      availableUnits: availableUnits ?? 0,
      price: price ?? 0,
    );
  }
}
