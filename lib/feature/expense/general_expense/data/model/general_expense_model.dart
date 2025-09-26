/// count : 17
/// next : "http://monkey-mania-production.up.railway.app/general_expense/all/?branch_id=1&branch_id=2&end_date=2027-5-9&page=2&start_date=2023-5-5"
/// previous : null
/// results : [{"id":17,"name":"booom","unit_price":"0.26","total_price":"89.00","quantity":336,"branch":"راس البر","created":"2025-08-15T05:41:19.982973+03:00","updated":"2025-08-15T05:41:19.982988+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":2},{"id":16,"name":"asss","unit_price":"100.66","total_price":"5033.00","quantity":50,"branch":"سافانا","created":"2025-08-15T05:40:46.837514+03:00","updated":"2025-08-15T05:40:46.837532+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":1},{"id":15,"name":"tasnem","unit_price":"2.20","total_price":"33.00","quantity":15,"branch":"سافانا","created":"2025-07-22T20:22:11.968235+03:00","updated":"2025-07-22T20:22:11.968255+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":1},{"id":14,"name":"tasnem","unit_price":"2.20","total_price":"33.00","quantity":15,"branch":"سافانا","created":"2025-07-22T20:20:51.602434+03:00","updated":"2025-07-22T20:20:51.602455+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":1},{"id":13,"name":"abdelrahman mahmoud","unit_price":"81.54","total_price":"4566.00","quantity":56,"branch":"راس البر","created":"2025-07-18T19:05:07.544647+03:00","updated":"2025-07-18T19:05:07.544661+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":2},{"id":12,"name":"tasnem","unit_price":"666.67","total_price":"2000.00","quantity":3,"branch":"سافانا","created":"2025-07-17T02:38:19.972244+03:00","updated":"2025-07-17T02:38:19.972259+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":1},{"id":11,"name":"testgenerfgfgdgdfal_expense1","unit_price":"1.78","total_price":"10000.00","quantity":5610,"branch":"راس البر","created":"2025-07-11T19:11:07.658751+03:00","updated":"2025-07-11T19:11:07.658767+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":2},{"id":10,"name":"testgenerfgfgdgdfal_expense1","unit_price":"200.00","total_price":"10000.00","quantity":50,"branch":"راس البر","created":"2025-07-11T19:11:01.676014+03:00","updated":"2025-07-11T19:11:01.676033+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":2},{"id":9,"name":"testgenerfgfgdgdfal_expense1","unit_price":"200.00","total_price":"10000.00","quantity":50,"branch":"راس البر","created":"2025-07-11T19:10:58.401791+03:00","updated":"2025-07-11T19:10:58.401814+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":2},{"id":8,"name":"testgenerfgfgdgdfal_expense1","unit_price":"200.00","total_price":"10000.00","quantity":50,"branch":"راس البر","created":"2025-07-11T19:10:57.997961+03:00","updated":"2025-07-11T19:10:57.997980+03:00","created_by":"ammar admin","created_by_id":1,"branch_id":2}]

class GeneralExpenseModel {
  GeneralExpenseModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  GeneralExpenseModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(ResultsGeneralExpenseModel.fromJson(v));
      });
    }
  }
  num? count;
  String? next;
  dynamic previous;
  List<ResultsGeneralExpenseModel>? results;
GeneralExpenseModel copyWith({  num? count,
  String? next,
  dynamic previous,
  List<ResultsGeneralExpenseModel>? results,
}) => GeneralExpenseModel(  count: count ?? this.count,
  next: next ?? this.next,
  previous: previous ?? this.previous,
  results: results ?? this.results,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 17
/// name : "booom"
/// unit_price : "0.26"
/// total_price : "89.00"
/// quantity : 336
/// branch : "راس البر"
/// created : "2025-08-15T05:41:19.982973+03:00"
/// updated : "2025-08-15T05:41:19.982988+03:00"
/// created_by : "ammar admin"
/// created_by_id : 1
/// branch_id : 2

class ResultsGeneralExpenseModel {
  ResultsGeneralExpenseModel({
      this.id, 
      this.name, 
      this.unitPrice, 
      this.totalPrice, 
      this.quantity, 
      this.branch, 
      this.created, 
      this.updated, 
      this.createdBy, 
      this.createdById, 
      this.branchId,});

  ResultsGeneralExpenseModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
    branch = json['branch'];
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    createdById = json['created_by_id'];
    branchId = json['branch_id'];
  }
  int? id;
  String? name;
  String? unitPrice;
  String? totalPrice;
  int? quantity;
  String? branch;
  String? created;
  String? updated;
  String? createdBy;
  num? createdById;
  num? branchId;
ResultsGeneralExpenseModel copyWith({  int? id,
  String? name,
  String? unitPrice,
  String? totalPrice,
  int? quantity,
  String? branch,
  String? created,
  String? updated,
  String? createdBy,
  num? createdById,
  num? branchId,
}) => ResultsGeneralExpenseModel(  id: id ?? this.id,
  name: name ?? this.name,
  unitPrice: unitPrice ?? this.unitPrice,
  totalPrice: totalPrice ?? this.totalPrice,
  quantity: quantity ?? this.quantity,
  branch: branch ?? this.branch,
  created: created ?? this.created,
  updated: updated ?? this.updated,
  createdBy: createdBy ?? this.createdBy,
  createdById: createdById ?? this.createdById,
  branchId: branchId ?? this.branchId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['unit_price'] = unitPrice;
    map['total_price'] = totalPrice;
    map['quantity'] = quantity;
    map['branch'] = branch;
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['created_by_id'] = createdById;
    map['branch_id'] = branchId;
    return map;
  }

}

