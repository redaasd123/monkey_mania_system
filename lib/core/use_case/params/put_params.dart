class UpdateSchoolParam {
  final String name;
  final String address;
  final String? notes;
  final int id;

  const UpdateSchoolParam({
    required this.id,
    required this.name,
    required this.address,
    this.notes,
  });
}