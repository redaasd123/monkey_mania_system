class UpdateCalculationsParam {
  final int? id;
  final int timePrice;
  final int visa;
  final int cash;
  final int instapay;

  UpdateCalculationsParam({
    this.id,
    required this.timePrice,
    required this.visa,
    required this.cash,
    required this.instapay,
  });

  Map<String, dynamic> toJson() {
    return {
      "time_price": timePrice,
      "visa": visa,
      "cash": cash,
      "instapay": instapay,
    };
  }
}
