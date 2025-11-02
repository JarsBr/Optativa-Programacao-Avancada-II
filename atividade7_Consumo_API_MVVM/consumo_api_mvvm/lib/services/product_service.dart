import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$baseUrl/products');
    final response = await http.get(uri).timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body) as List;
      return data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Falha ao carregar produtos (código ${response.statusCode}).');
  }

  Future<Product> fetchProductById(int id) async {
    final uri = Uri.parse('$baseUrl/products/$id');
    final response = await http.get(uri).timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      return Product.fromJson(data);
    }
    throw Exception('Falha ao carregar produto #$id (código ${response.statusCode}).');
  }
}
