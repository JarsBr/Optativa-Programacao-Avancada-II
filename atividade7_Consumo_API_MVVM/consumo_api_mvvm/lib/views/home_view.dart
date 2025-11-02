import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_routes.dart';
import '../viewmodels/product_list_view_model.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/product_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductListViewModel>();

    Widget body;
    switch (vm.state) {
      case ViewState.loading:
        body = const LoadingView();
        break;
      case ViewState.error:
        body = ErrorView(
          message: vm.errorMessage ?? 'Ocorreu um erro ao carregar.',
          onRetry: () => context.read<ProductListViewModel>().fetchProducts(),
        );
        break;
      case ViewState.idle:
        if (vm.products.isEmpty) {
          body = ErrorView(
            message: 'Nenhum produto encontrado.',
            onRetry: () => context.read<ProductListViewModel>().fetchProducts(),
          );
        } else {
          body = RefreshIndicator(
            onRefresh: () => context.read<ProductListViewModel>().fetchProducts(),
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: vm.products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = vm.products[index];
                return ProductTile(
                  product: product,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productDetail,
                    arguments: product, // envia o objeto inteiro
                  ),
                );
              },
            ),
          );
        }
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo Online')),
      body: body,
    );
  }
}
