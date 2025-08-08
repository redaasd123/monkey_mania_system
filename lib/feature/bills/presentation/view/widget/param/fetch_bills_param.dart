class FetchBillsParam {
  final List<dynamic>? branch;
  final DateTime? startDate;
  final DateTime? endDate;

  FetchBillsParam({
     this.branch,
     this.startDate,
     this.endDate,
  });

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> queryParams = {};

    if (startDate != null) {
      queryParams["start_date"] = startDate!.toIso8601String().split("T").first;
    }

    if (endDate != null) {
      queryParams["end_date"] = endDate!.toIso8601String().split("T").first;
    }
if(branch!=null) {
  queryParams["branch_id"] = branch!.map((id) => id.toString()).toList();
}
    return queryParams;
  }


}
