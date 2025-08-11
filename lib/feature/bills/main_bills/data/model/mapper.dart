import '../../domain/entity/get_one_bills_entity.dart';
import 'get_one_bills_model.dart';

extension GetOneBillMapper on GetOneBiilsModel {
  GetOneBillsEntity toEntity() {
    return GetOneBillsEntity(
      id: id ?? 0,
      cash: cash,
      instapay: instapay,
      visa: visa,
      timePrice: timePrice,
      productsPrice: productsPrice,
      totalPrice: totalPrice,
      discountValue: discountValue,
      discountType: discountType,
      branch: branch,
      spentTime: spentTime,
      childrenCount: childrenCount,
      children: children?.map((c)=>c.toEntity()).toList(),
      hourPrice: hourPrice,
      halfHourPrice: halfHourPrice,
      moneyUnbalance: moneyUnbalance?.toDouble(),
      finished: finished != null ? DateTime.parse(finished!) : null,
      created: created != null ? DateTime.parse(created!) : null,
      updated: updated != null ? DateTime.parse(updated!) : null,
      createdBy: createdBy,
      finishedBy: finishedBy,
      isSubscription: isSubscription,
      isActive: isActive,
    );
  }
}

extension ChildrenMapper on Children {
  ChildrenEntity toEntity() {
    return ChildrenEntity(
      id: id,
      name: name,
      phoneNumbers: phoneNumbers?.map((p) => p.toEntity()).toList(),
    );
  }
}

extension PhoneNumberMapper on PhoneNumbers {
  PhoneNumberEntity toEntity() {
    return PhoneNumberEntity(
      phoneNumber: phoneNumber,
      relationship: relationship,
    );
  }
}
