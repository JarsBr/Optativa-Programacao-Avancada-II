import 'package:flutter/material.dart';
import 'edit_recipe_page.dart';

class RecipeDetailPage extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String ingredientes;
  final String preparo;
  final String imagem;

  const RecipeDetailPage({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.ingredientes,
    required this.preparo,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final receitaEditada = await Navigator.push<Map<String, String>?>(
                context,
                MaterialPageRoute(
                  builder: (_) => EditRecipePage(
                    receita: {
                      'titulo': titulo,
                      'descricao': descricao,
                      'ingredientes': ingredientes,
                      'preparo': preparo,
                      'imagem': imagem,
                    },
                  ),
                ),
              );

              if (receitaEditada != null && context.mounted) {
                Navigator.pop(context, receitaEditada);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: Image.asset(
                imagem,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Image.asset('assets/default.jpg', fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            descricao,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ingredientes:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(ingredientes),
          const SizedBox(height: 20),
          const Text(
            'Modo de Preparo:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(preparo),
        ],
      ),
    );
  }
}
