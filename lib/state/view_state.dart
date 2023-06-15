import 'package:flutter/cupertino.dart';
import '../entity/search_repository.dart';
import '../network/api_client.dart';

class ViewState extends ChangeNotifier {
  final apiClient = APIClient();

  bool searchBoolean = false;

  bool visibleIndicator = false;

  SearchRepository searchRepository = SearchRepository(
    totalCount: 0,
    incompleteResults: false,
    items: [],
  );

  void enableSearchMode() {
    searchBoolean = true;
    notifyListeners();
  }

  void disableSearchMode() {
    searchBoolean = false;
    notifyListeners();
  }

  void showIndicator() {
    visibleIndicator = true;
    notifyListeners();
  }

  void hideIndicator() {
    visibleIndicator = false;
    notifyListeners();
  }

  Future<void> fetchSearchRepository(String q) async {
    searchRepository = await apiClient.getSearchRepository(q);
    notifyListeners();
  }
}