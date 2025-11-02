import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductService _service;

  Product? _product;
  Product? get product => _product;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final int? productId;

  ProductDetailViewModel(this._service, {this.productId, Product? initialProduct}) {
    if (initialProduct != null) {
      _product = initialProduct;
    }
  }

  Future<void> fetchById() async {
    if (productId == null) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _product = await _service.fetchProductById(productId!);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
