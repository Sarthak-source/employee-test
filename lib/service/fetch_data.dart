import 'dart:convert';
import 'package:employee_test/modals/pagiantion.dart';
import 'package:flutter/services.dart';

class MockDataService {
  static Future<PaginatedData> fetchData(int page, int pageSize) async {
    final jsonString = await rootBundle.loadString('assets/employees.json');
    final jsonData = json.decode(jsonString);

    final paginatedData = PaginatedData.fromJson(jsonData);
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    if (startIndex >= paginatedData.totalItems) {
      return PaginatedData(
        currentPage: page,
        totalPages: paginatedData.totalPages,
        pageSize: pageSize,
        totalItems: paginatedData.totalItems,
        items: [],
      );
    } else {
      return PaginatedData(
        currentPage: page,
        totalPages: paginatedData.totalPages,
        pageSize: pageSize,
        totalItems: paginatedData.totalItems,
        items: paginatedData.items.sublist(startIndex, endIndex),
      );
    }
  }
  MockDataService._();
}
