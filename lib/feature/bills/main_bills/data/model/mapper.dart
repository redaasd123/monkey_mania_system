import '../../domain/entity/get_one_bills_entity.dart';
import 'get_one_bills_model.dart';

extension GetOneBillMapper on GetOneBillsModel {
  GetOneBillsEntity toEntity() {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    DateTime? parseDate(String? date) {
      if (date == null) return null;
      return DateTime.tryParse(date);
    }

    return GetOneBillsEntity(
      id: id ?? 0,
      cash: parseDouble(cash),
      instapay: parseDouble(instapay),
      visa: parseDouble(visa),
      timePrice: parseDouble(timePrice),
      productsPrice: parseDouble(productsPrice),
      totalPrice: parseDouble(totalPrice),
      discountValue: parseDouble(discountValue),
      discountType: discountType,
      branch: branch,
      spentTime: spentTime,
      childrenCount: childrenCount,
      children: children?.map((c) => c.toEntity()).toList(),
      hourPrice: parseDouble(hourPrice),
      halfHourPrice: parseDouble(halfHourPrice),
      moneyUnbalance: moneyUnbalance?.toDouble(),
      finished: parseDate(finished),
      created: parseDate(created),
      updated: parseDate(updated),
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




