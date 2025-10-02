import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final allObjects = <dynamic>[].obs;
  final filteredObjects = <dynamic>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final _isDataLoaded = false.obs;
  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (!_isDataLoaded.value) {
      fetchAllObjects();
    }
  }

  Future<void> fetchAllObjects() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      error.value = '';
      final response = await http.get(
        Uri.parse('https://api.restful-api.dev/objects'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        allObjects.assignAll(data);
        filteredObjects.assignAll(data);
        _isDataLoaded.value = true;
      } else {
        throw Exception('Failed to load objects: ${response.statusCode}');
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchObjects(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      filteredObjects.assignAll(allObjects);
      return;
    }

    final keywords = query.toLowerCase().split(' ').where((word) => word.isNotEmpty).toList();

    final results = allObjects.where((obj) {
      // Combine all searchable fields into one string
      final data = obj['data'];
      String searchableText = (
          (obj['name'] ?? '') + ' ' +
              (obj['id'] ?? '') + ' ' +
              (data != null && data is Map
                  ? data.entries.map((e) => '${e.key} ${e.value}').join(' ')
                  : '')
      ).toLowerCase();

      // Check if all keywords are present
      return keywords.every((word) => searchableText.contains(word));
    }).toList();

    filteredObjects.assignAll(results);
  }


  void refreshData() {
    fetchAllObjects();
  }

  int getDataCount(dynamic obj) {
    final data = obj['data'];
    return (data != null && data is Map) ? data.keys.length : 0;
  }

  bool get isDataLoaded => _isDataLoaded.value;

  void clearSearch() {
    searchText.value = '';
    filteredObjects.assignAll(allObjects);
  }
}
