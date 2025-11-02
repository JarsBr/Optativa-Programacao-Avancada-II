import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_routes.dart';
import 'services/product_service.dart';
import 'viewmodels/product_list_view_model.dart';
import 'views/home_view.dart';

class CatalogoOnlineApp extends StatelessWidget {
  const CatalogoOnlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductService>(create: (_) => ProductService()),
        ChangeNotifierProvider<ProductListViewModel>(
          create: (ctx) => ProductListViewModel(ctx.read<ProductService>())..fetchProducts(),
        ),
      ],
      child: MaterialApp(
        title: 'Catálogo Online',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066CC)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const HomeView(),
      ),
    );
  }
}
