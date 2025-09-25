import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String ingredientes;
  final String preparo;

  const RecipeDetailPage({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.ingredientes,
    required this.preparo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(descricao,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            const SizedBox(height: 20),
            const Text('Ingredientes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(ingredientes),
            const SizedBox(height: 20),
            const Text('Modo de Preparo:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(preparo),
          ],
        ),
      ),
    );
  }
}
