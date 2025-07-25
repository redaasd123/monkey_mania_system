class PostSchoolParam {
  final String name;
  final String address;
  final String? notes;   // ← Nullable

  const PostSchoolParam({
    required this.name,
    required this.address,
    this.notes,
  });
}