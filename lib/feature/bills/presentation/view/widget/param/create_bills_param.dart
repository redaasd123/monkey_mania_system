
class CreateBillsParam {
  final String discount;
  final List<int> childrenId;
  final List<NewChildren> newChildren;
  final int branch;

  CreateBillsParam({
    required this.discount,
    required this.childrenId,
    required this.newChildren,
    required this.branch,
  });

  Map<String, dynamic> toJson() {
    return {
      "discount": discount,
      "children": childrenId,
      "new_children": newChildren.map((child) => child.toJson()).toList(),
      "branch": branch,
    };
  }
}

class NewChildren {
  final String name;
  final String dateBirth;
  final List<PhoneNumber> phoneNumber;

  NewChildren({
    required this.name,
    required this.dateBirth,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birth_date': dateBirth,
      "child_phone_numbers_set":
      phoneNumber.map((phone) => phone.toJson()).toList(),
    };
  }
}

class PhoneNumber {
  final String value;
  final String relationship;

  PhoneNumber({required this.value, required this.relationship});

  Map<String, dynamic> toJson() {
    return {
      "phone_number": {'value': value},
      'relationship': relationship,
    };
  }
}
