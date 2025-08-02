class FetchBillsPram {
  final int branchId;
  final String startDate;
  final String endDate;

  FetchBillsPram({
    required this.branchId,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'branch_id': branchId,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
