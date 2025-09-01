import '../../../../bills/main_bills/domain/entity/get_one_bills_entity.dart';

class PaginatedChildren {
  final List<ChildrenEntity> children;
  final String? next;
  final String? previous;
  final int count;

  PaginatedChildren({
    required this.children,
    required this.next,
    required this.previous,
    required this.count,
  });
}
