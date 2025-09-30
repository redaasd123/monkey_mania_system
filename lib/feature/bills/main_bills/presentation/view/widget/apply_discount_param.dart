class ApplyDiscountParams {
  final int? id;
  final String discount;

  ApplyDiscountParams({required this.id, required this.discount});

  Map<String, dynamic> toJson() {
    return {"discount": discount};
  }
}
