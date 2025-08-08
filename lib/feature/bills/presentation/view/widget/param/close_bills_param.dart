class CloseBillsParam {
  final num? id;
  final num visa;
  final num cash;
  final num instaPay;

  CloseBillsParam({
    required this.id,
    required this.visa,
    required this.cash,
    required this.instaPay,
  });

  Map<String,dynamic> toJon(){
    return{
      "visa":visa,
      "insta_pay":instaPay,
      "vodafone_cash":cash,
    };
  }
}
