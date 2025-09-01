import 'Bills_entity.dart';

class BillsPageEntity {
  final List<BillsEntity> bills;
  final int? nextPage;
  final int? previousPage;

  BillsPageEntity({
    required this.bills,
    this.nextPage,
    this.previousPage,
  });
}
