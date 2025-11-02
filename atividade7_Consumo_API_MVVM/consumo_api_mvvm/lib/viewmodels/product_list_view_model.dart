import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';

enum ViewState { idle, loading, error }

class ProductListViewModel extends ChangeNotifier {
  final ProductService _service;

  ProductListViewModel(this._service);

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<Product> _products = [];
  List<Product> get products => _products;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _setState(ViewState.loading);
    try {
      _products = await _service.fetchProducts();
      _errorMessage = null;
      _setState(ViewState.idle);
    } catch (e) {
      _errorMessage = e.toString();
      _products = [];
      _setState(ViewState.error);
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
