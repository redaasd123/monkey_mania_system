class FetchBillsParam {
  final List<dynamic>? branch;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? page;
  final String? query;
  final String? layer1;
  final String? layer2;
  final String analyticsType;

  const FetchBillsParam({
    this.analyticsType = 'phone_number',
    this.layer2,
    this.layer1,
    this.page = 1,
    this.branch,
    this.startDate,
    this.endDate,
    this.query,
  });

  FetchBillsParam copyWith({
    String? analyticsType,
    List<dynamic>? branch,
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    String? query,
    String? layer1,
    String? layer2,
  }) {
    return FetchBillsParam(
      analyticsType: analyticsType ?? this.analyticsType,
      branch: branch ?? this.branch,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      page: page ?? this.page,
      query: query ?? this.query,
      layer1: layer1 ?? this.layer1,
      layer2: layer2 ?? this.layer2,
    );
  }

  /// يحول كل البيانات إلى query string جاهز للـ URL بنفس اسم الدالة
  String toQueryParams() {
    List<String> parts = [];

    // Branch
    if (branch != null && branch!.isNotEmpty) {
      parts.addAll(branch!.map((id) => "branch_id=$id"));
    } else {
      parts.add("branch_id=all");
    }

    // Page
    if (page != null) {
      parts.add("page=$page");
    }

    // Start date
    if (startDate != null) {
      parts.add("start_date=${startDate!.toIso8601String().split('T').first}");
    }

    // End date
    if (endDate != null) {
      parts.add("end_date=${endDate!.toIso8601String().split('T').first}");
    }

    // Search query
    if (query != null && query!.isNotEmpty) {
      parts.add("search=${query!}");
    }
    if (layer1 != null) {
      parts.add('layer1=${layer1}');
    }
    if (layer2 != null) {
      parts.add('layer2=${layer2}');
    }
    if (analyticsType != null) {
      parts.add("type=${analyticsType}");
    }

    return parts.join("&");
  }
}
