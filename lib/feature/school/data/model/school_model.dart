import 'package:intl/intl.dart';
import 'package:monkey_app/feature/school/domain/entity/school_entity.dart';

class SchoolModel extends SchoolEntity {
  final int id;
  final String name;
  final String address;
  final String? notes;
  final DateTime created; // ← DateTime بدل String
  final DateTime updated;
  final String createdBy;

  SchoolModel({
    required this.id,
    required this.name,
    required this.address,
    required this.notes,
    required this.created,
    required this.updated,
    required this.createdBy,
  }) : super(
         name: name,
         address: address,
         notes: notes,
         id: id,
         created: created,
         createdBy: createdBy,
         updated: updated,
       );

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
    id: json['id'] as int,
    name: json['name'] as String,
    address: json['address'] as String,
    notes: json['notes'],
    created: DateTime.parse(json['created']),
    // ← التحويل
    updated: DateTime.parse(json['updated']),
    createdBy: json['created_by'].toString(),
  );

  /// getter يعيد الوقت فقط بصيغة HH:mm
  String get createdTime => DateFormat('HH:mm').format(created); // 👈 14:45
}

class PostModel {
  final int id;
  final String name;
  final String address;
  final String? notes;
  final DateTime created;
  final DateTime updated;
  final String createdBy;
  final String message;

  PostModel({
    required this.message,
    required this.id,
    required this.name,
    required this.address,
    required this.notes,
    required this.created,
    required this.updated,
    required this.createdBy,
  });

  /// ✔️ Factory من الـ API (JSON)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    final createdUtc = DateTime.parse(json['created']).toLocal();
    return PostModel(
      message: json['message'] ?? '',
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      notes: json['notes'],
      created: createdUtc,
      updated: DateTime.parse(json['updated']).toLocal(),
      createdBy: json['created_by'].toString(),
    );
  }

  /// ✔️ Factory يحوِّل SchoolModel → PostModel
  factory PostModel.fromSchoolModel(SchoolModel s) {
    return PostModel(
      id: s.id,
      name: s.name,
      address: s.address,
      notes: s.notes,
      // قيم افتراضيّة لأن SchoolModel لا يحمل هذه الحقول
      created: DateTime.now(),
      updated: DateTime.now(),
      createdBy: 'local',
      message: '',
    );
  }

  /// صيغة الوقت المحلّي (مثال: 14:45)
  String get createdTime => DateFormat('HH:mm').format(created.toLocal());
}
