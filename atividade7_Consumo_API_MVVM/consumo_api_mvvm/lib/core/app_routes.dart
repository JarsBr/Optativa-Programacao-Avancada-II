import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../viewmodels/product_detail_view_model.dart';
import '../views/product_detail_view.dart';

class AppRoutes {
  static const productDetail = '/product-detail';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productDetail:
        final args = settings.arguments;
        if (args is Product) {
          // Passa o produto para a tela de detalhes via ViewModel
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => ProductDetailViewModel(
                context.read<ProductService>(),
                initialProduct: args,
              ),
              child: const ProductDetailView(),
            ),
          );
        } else if (args is int) {
          // Carrega por id se só veio o ID
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => ProductDetailViewModel(
                context.read<ProductService>(),
                productId: args,
              )..fetchById(),
              child: const ProductDetailView(),
            ),
          );
        }
        return _errorRoute('Argumentos inválidos para detalhes do produto.');
      default:
        return null;
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
