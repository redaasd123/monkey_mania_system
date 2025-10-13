import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/param/return_product_param.dart';

import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../param/create_bills_coffee_param.dart';
import '../entity/coffee_bills_page_entity.dart';

abstract class CoffeeBillsRepo {
  Future<Either<Failure, BillsCoffeePageEntity>> fetchAllCoffeeBills(
    RequestParameters param,
  );

  Future<Either<Failure, List<BillsCoffeeEntity>>> fetchActiveCoffeeBills(
    RequestParameters param,
  );

  Future<Either<Failure, BillsCoffeeEntity>> returnProduct(
    ReturnProductsParam param,
  );

  Future<Either<Failure, GetOneBillsCoffeeEntity>> getOneCoffeeBills(int id);

  Future<Either<Failure, BillsCoffeeEntity>> createCoffeeBills(
    CreateBillsPCoffeeParam param,
  );

  Future<Either<Failure, List<LayersEntity>>> getLayerOne(
    RequestParameters param,
  );

  Future<Either<Failure, List<LayersEntity>>> getLayerTow(
    RequestParameters param,
  );

  Future<Either<Failure, List<GetAllLayerEntity>>> getAllLayers(
    RequestParameters param,
  );
}
