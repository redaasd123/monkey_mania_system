/// count : 10
/// next : null
/// previous : null
/// results : [{"id":17,"username":"سيف التمامي","phone_number":"01229100972","email":null,"role":"waiter","is_active":true,"created":"2025-10-02T21:09:55.140141+03:00","updated":"2025-10-02T21:09:55.140226+03:00","created_by":"ammar admin","branch":"راس البر","staff":null,"last_login":null,"last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":2},{"id":16,"username":"علي عبدالرحمن","phone_number":"01279179116","email":null,"role":"waiter","is_active":true,"created":"2025-09-30T21:42:04.637030+03:00","updated":"2025-09-30T21:42:04.637048+03:00","created_by":"ammar admin","branch":"راس البر","staff":null,"last_login":null,"last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":2},{"id":15,"username":"manager rasalbar","phone_number":"01035261399","email":null,"role":"manager","is_active":true,"created":"2025-08-28T02:34:31.357000+03:00","updated":"2025-08-28T02:34:31.357000+03:00","created_by":"ammar admin","branch":"راس البر","staff":null,"last_login":"2025-10-01T15:50:16.461788+03:00","last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":2},{"id":14,"username":"Abo Matlida Reception rasalbar","phone_number":"01558673598","email":"ammrar444r@gmail.com","role":"reception","is_active":true,"created":"2025-07-11T03:36:26.071000+03:00","updated":"2025-07-11T03:36:26.071000+03:00","created_by":"ammar admin","branch":"راس البر","staff":null,"last_login":"2025-10-02T04:06:06.235686+03:00","last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":2},{"id":12,"username":"reception savana","phone_number":"01130269025","email":"ammrrrar4r@gmail.com","role":"reception","is_active":true,"created":"2025-07-11T03:37:12.774000+03:00","updated":"2025-07-11T03:53:59.145000+03:00","created_by":"ammar admin","branch":"سافانا","staff":null,"last_login":"2025-10-01T15:51:21.626535+03:00","last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":1},{"id":11,"username":"waiter rasalbar","phone_number":"01039269025","email":null,"role":"waiter","is_active":true,"created":"2025-07-11T03:36:26.071000+03:00","updated":"2025-07-11T03:36:26.071000+03:00","created_by":"ammar admin","branch":"راس البر","staff":null,"last_login":"2025-09-30T10:23:51.262223+03:00","last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":2},{"id":10,"username":"waiter savana","phone_number":"01030269025","email":"ammrar4r@gmail.com","role":"waiter","is_active":true,"created":"2025-07-11T03:33:39.852000+03:00","updated":"2025-09-08T22:39:17.339667+03:00","created_by":"ammar admin","branch":"سافانا","staff":null,"last_login":"2025-10-01T15:51:00.600623+03:00","last_logout":"2025-09-08T22:39:17.338936+03:00","created_by_id":1,"staff_id":null,"branch_id":1},{"id":7,"username":"manager savana","phone_number":"01035261346","email":"ammar2@gmail.com","role":"manager","is_active":true,"created":"2025-07-10T03:04:38.531000+03:00","updated":"2025-07-10T03:04:38.531000+03:00","created_by":"ammar admin","branch":"سافانا","staff":null,"last_login":"2025-10-01T01:46:38.267002+03:00","last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":1},{"id":2,"username":"reception rasalbar","phone_number":"01236985412","email":"ammar@gmail.com","role":"reception","is_active":true,"created":"2025-07-09T23:21:30.284000+03:00","updated":"2025-07-09T23:21:30.284000+03:00","created_by":"ammar admin","branch":"راس البر","staff":null,"last_login":"2025-09-30T10:30:55.228474+03:00","last_logout":null,"created_by_id":1,"staff_id":null,"branch_id":2},{"id":1,"username":"ammar admin","phone_number":"01030261346","email":null,"role":"admin","is_active":true,"created":"2025-07-02T15:26:38+03:00","updated":"2025-09-30T21:44:12.399000+03:00","created_by":null,"branch":null,"staff":null,"last_login":"2025-10-05T02:06:28.311758+03:00","last_logout":"2025-09-09T00:56:05.288000+03:00","created_by_id":null,"staff_id":null,"branch_id":null}]

class UserModel {
  UserModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  UserModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(UsersResults.fromJson(v));
      });
    }
  }
  num? count;
  dynamic next;
  dynamic previous;
  List<UsersResults>? results;
UserModel copyWith({  num? count,
  dynamic next,
  dynamic previous,
  List<UsersResults>? results,
}) => UserModel(  count: count ?? this.count,
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
/// username : "سيف التمامي"
/// phone_number : "01229100972"
/// email : null
/// role : "waiter"
/// is_active : true
/// created : "2025-10-02T21:09:55.140141+03:00"
/// updated : "2025-10-02T21:09:55.140226+03:00"
/// created_by : "ammar admin"
/// branch : "راس البر"
/// staff : null
/// last_login : null
/// last_logout : null
/// created_by_id : 1
/// staff_id : null
/// branch_id : 2

class UsersResults {
  UsersResults({
      this.id, 
      this.username, 
      this.phoneNumber, 
      this.email, 
      this.role, 
      this.isActive, 
      this.created, 
      this.updated, 
      this.createdBy, 
      this.branch, 
      this.staff, 
      this.lastLogin, 
      this.lastLogout, 
      this.createdById, 
      this.staffId, 
      this.branchId,});

  UsersResults.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    role = json['role'];
    isActive = json['is_active'];
    created = json['created'];
    updated = json['updated'];
    createdBy = json['created_by'];
    branch = json['branch'];
    staff = json['staff'];
    lastLogin = json['last_login'];
    lastLogout = json['last_logout'];
    createdById = json['created_by_id'];
    staffId = json['staff_id'];
    branchId = json['branch_id'];
  }
  int? id;
  String? username;
  String? phoneNumber;
  dynamic email;
  String? role;
  bool? isActive;
  String? created;
  String? updated;
  String? createdBy;
  String? branch;
  dynamic staff;
  dynamic lastLogin;
  dynamic lastLogout;
  num? createdById;
  dynamic staffId;
  num? branchId;
UsersResults copyWith({  int? id,
  String? username,
  String? phoneNumber,
  dynamic email,
  String? role,
  bool? isActive,
  String? created,
  String? updated,
  String? createdBy,
  String? branch,
  dynamic staff,
  dynamic lastLogin,
  dynamic lastLogout,
  num? createdById,
  dynamic staffId,
  num? branchId,
}) => UsersResults(  id: id ?? this.id,
  username: username ?? this.username,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  email: email ?? this.email,
  role: role ?? this.role,
  isActive: isActive ?? this.isActive,
  created: created ?? this.created,
  updated: updated ?? this.updated,
  createdBy: createdBy ?? this.createdBy,
  branch: branch ?? this.branch,
  staff: staff ?? this.staff,
  lastLogin: lastLogin ?? this.lastLogin,
  lastLogout: lastLogout ?? this.lastLogout,
  createdById: createdById ?? this.createdById,
  staffId: staffId ?? this.staffId,
  branchId: branchId ?? this.branchId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['phone_number'] = phoneNumber;
    map['email'] = email;
    map['role'] = role;
    map['is_active'] = isActive;
    map['created'] = created;
    map['updated'] = updated;
    map['created_by'] = createdBy;
    map['branch'] = branch;
    map['staff'] = staff;
    map['last_login'] = lastLogin;
    map['last_logout'] = lastLogout;
    map['created_by_id'] = createdById;
    map['staff_id'] = staffId;
    map['branch_id'] = branchId;
    return map;
  }

}