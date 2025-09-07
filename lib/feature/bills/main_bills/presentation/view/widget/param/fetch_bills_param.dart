class FetchBillsParam {
  final List<dynamic>? branch;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? page;
  final String? query;
  final String? layer1;
  final String? layer2;

  FetchBillsParam({
    this.layer2,
    this.layer1 ,
    this.page = 1,
    this.branch,
    this.startDate,
    this.endDate,
    this.query,
  });

  /// يحول كل البيانات إلى query string جاهز للـ URL بنفس اسم الدالة
  String toQueryParams() {
    List<String> parts = [];

    // Branch
    if (branch != null && branch!.isNotEmpty) {
      parts.addAll(branch!.map((id) => "branch_id=$id"));
     }
      else {
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
    if(layer1!=null){
      parts.add('layer1=${layer1}');
    }
    if(layer2!=null){
      parts.add('layer2=${layer2}');
    }

    return parts.join("&");
  }
}
