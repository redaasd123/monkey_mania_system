import 'package:equatable/equatable.dart';

class UpdateExpenseParam extends Equatable {
  final int? id ;
  final String? name;
  final int? branchId;
  final String? totalPrice;
  final String? quantity;
  final int? materialId;

  const UpdateExpenseParam({
    this.materialId,
     this.id,
     this.name,
     this.branchId,
     this.totalPrice,
     this.quantity,
  });

  Map<String, dynamic> toJson() {
   final  Map<String,dynamic> data = {};

   if (name != null) data['name'] = name;
   if (branchId != null) data['branch'] = branchId;
   if (totalPrice != null) data['total_price'] = totalPrice;
   if (quantity != null) data['quantity'] = quantity;
   if (materialId != null) data['material'] = materialId;
    return data;
  }

  @override
  List<Object?> get props => [name, branchId, totalPrice, quantity];
}
