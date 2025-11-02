import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_detail_view_model.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductDetailViewModel>();
    final product = vm.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product?.title ?? 'Detalhes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Voltar',
        ),
      ),
      body: Builder(
        builder: (_) {
          if (vm.isLoading) return const LoadingView();
          if (vm.errorMessage != null) {
            return ErrorView(
              message: vm.errorMessage!,
              onRetry: vm.fetchById,
            );
          }
          if (product == null) {
            return const Center(child: Text('Produto não encontrado.'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(product.image, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Categoria: ${product.category}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
