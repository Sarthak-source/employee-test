import 'items.dart';

class PaginatedData {
  final int? currentPage;
  final int? totalPages;
  final int? pageSize;
  final int totalItems;
  final List<Item> items;

  PaginatedData({
    this.currentPage,
    this.totalPages,
    this.pageSize,
    required this.totalItems,
    required this.items,
  });

  factory PaginatedData.fromJson(List<dynamic> json) {
    final List<dynamic> rawItems = json;
    final items = rawItems.map((item) => Item.fromJson(item)).toList();

    return PaginatedData(
      totalItems: 5,
      items: items,
    );
  }
}