import 'package:flutter/foundation.dart';
import 'package:recipe_circle/models/product_model.dart';
import 'package:recipe_circle/services/product_service.dart';
import 'package:recipe_circle/models/category.dart' as rc;

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  final List<rc.Category> _categories = [
    rc.Category(id: 'mens', name: "Men's"),
    rc.Category(id: 'womens', name: "Woman's"),
    rc.Category(id: 'electronics', name: "Electronics"),
    rc.Category(id: 'jewellery', name: "Jewellery"),
  ];

  String _homeSelectedCategoryId = 'mens';

  String _searchSelectedCategoryId = 'mens';

  bool _showAllCategories = false;
  final List<Product> _favorites = [];

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;
  List<rc.Category> get categories => _categories;
  List<rc.Category> get displayedCategories =>
      _showAllCategories ? _categories : _categories.take(3).toList();

  String get homeSelectedCategoryId => _homeSelectedCategoryId;
  String get searchSelectedCategoryId => _searchSelectedCategoryId;

  bool get showAllCategories => _showAllCategories;
  List<Product> get favorites => _favorites;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _productService.getProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectHomeCategory(String categoryId) {
    if (_homeSelectedCategoryId != categoryId) {
      _homeSelectedCategoryId = categoryId;
      notifyListeners();
    }
  }

  void selectSearchCategory(String categoryId) {
    if (_searchSelectedCategoryId != categoryId) {
      _searchSelectedCategoryId = categoryId;
      notifyListeners();
    }
  }

  void toggleShowAllCategories() {
    _showAllCategories = !_showAllCategories;
    if (_homeSelectedCategoryId == 'jewellery' && !_showAllCategories) {
      _homeSelectedCategoryId = 'mens';
    }
    if (_searchSelectedCategoryId == 'jewellery' && !_showAllCategories) {
      _searchSelectedCategoryId = 'mens';
    }
    notifyListeners();
  }

  List<Product> getProductsByCategory(String categoryId) {
    switch (categoryId) {
      case 'mens':
        return _products
            .where((product) => product.category == "men's clothing")
            .toList();
      case 'womens':
        return _products
            .where((product) => product.category == "women's clothing")
            .toList();
      case 'electronics':
        return _products
            .where((product) => product.category == "electronics")
            .toList();
      case 'jewellery':
        return _products
            .where((product) => product.category == "jewelery")
            .toList();
      default:
        return _products;
    }
  }

  List<Product> getHomeProducts() {
    return getProductsByCategory(_homeSelectedCategoryId);
  }

  List<Product> getSearchProducts() {
    return getProductsByCategory(_searchSelectedCategoryId);
  }

  bool isFavorite(Product product) {
    return _favorites.any((favProduct) => favProduct.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((favProduct) => favProduct.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
