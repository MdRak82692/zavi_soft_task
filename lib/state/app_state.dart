import 'package:flutter/material.dart';
import '../data/models/product.dart';
import '../data/models/user.dart';
import '../data/services/api_service.dart';

class AppState with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _allProducts = [];
  List<String> _categories = ['All'];
  Map<String, List<Product>> _categoryProducts = {};
  User? _currentUser;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  Product? _selectedProduct;
  bool _isLoadingDetails = false;

  List<Product> get allProducts => _allProducts;
  List<String> get categories => _categories;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoadingDetails => _isLoadingDetails;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Product> getProductsForCategory(String category) {
    List<Product> baseList = (category == 'All')
        ? _allProducts
        : (_categoryProducts[category] ?? []);

    if (_searchQuery.isEmpty) return baseList;

    return baseList
        .where(
          (p) =>
              p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              p.description.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  Future<void> fetchProductDetails(int id) async {
    _isLoadingDetails = true;
    _selectedProduct = null;
    notifyListeners();

    try {
      _selectedProduct = await _apiService.getProductById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingDetails = false;
      notifyListeners();
    }
  }

  Future<void> fetchInitialData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Parallel fetch products, categories, and user (id 1 for mock)
      final results = await Future.wait([
        _apiService.getProducts(),
        _apiService.getCategories(),
        _apiService.getUser(1),
      ]);

      _allProducts = results[0] as List<Product>;
      _categories = ['All', ...(results[1] as List<String>)];
      _currentUser = results[2] as User;

      // Group products by category for easy access
      _categoryProducts = {};
      for (var product in _allProducts) {
        _categoryProducts.putIfAbsent(product.category, () => []).add(product);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await fetchInitialData();
  }
}
