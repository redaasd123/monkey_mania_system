class FetchBillsParam {
  final List<dynamic>? branch;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? page;
  final String? query;

  FetchBillsParam({this.page = 1, this.branch, this.startDate, this.endDate,this.query});
  FetchBillsParam copyWith({
    List<dynamic>? branch,
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    String? query,
  }) {
    return FetchBillsParam(
      branch: branch ?? this.branch,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      page: page ?? this.page,
      query: query ?? this.query,
    );
  }
  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> queryParams = {};

    if (startDate != null) {
      queryParams["start_date"] = startDate!.toIso8601String().split("T").first;
    }

    if (endDate != null) {
      queryParams["end_date"] = endDate!.toIso8601String().split("T").first;
    }

    // if (branch != null && branch!.isNotEmpty) {
    //   queryParams["branch_id"] = branch!.map((id) => id.toString()).toList();
    // } else {
    //   queryParams["branch_id"] = ["all"];
    // }

    if (branch != null && branch!.isNotEmpty) {
      queryParams["branch_id"] = branch!.map((id)=>id.toString()).toList();
    } else {
      queryParams["branch_id"] = "all";
    }

    if (page != null) {
      queryParams["page"] = page!;
    }
    if(query!=null){
      queryParams['search'] = query;
    }

    return queryParams;
  }
}


