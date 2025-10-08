import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/get_all_layers_entity.dart';

part 'order_state.dart';



class OrderItem {
  final GetAllLayerEntity product;
  final int quantity;
  final String? notes;
  final String imagePath;

  OrderItem({
    required this.imagePath,
    required this.product,
    required this.quantity,
    required this.notes,
  });
}

class OrdersCubit extends Cubit<List<OrderItem>> {
  OrdersCubit() : super([]);
  final List<OrderItem> productList = [];
  void addOrder(OrderItem order) {
    final updated = List<OrderItem>.from(state)..add(order);
    emit(updated);
  }

  void removeOrder(int index) {
    final updated = List<OrderItem>.from(state)..removeAt(index);
    emit(updated);
  }
  void updateOrder(int index, OrderItem updatedOrder) {
    final updated = List<OrderItem>.from(state);
    updated[index] = updatedOrder;
    emit(updated);
  }

  void clearOrders() {
    emit([]); //
  }


}

