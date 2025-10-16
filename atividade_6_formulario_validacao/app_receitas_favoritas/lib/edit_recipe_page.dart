import 'package:flutter/material.dart';

class EditRecipePage extends StatefulWidget {
  final Map<String, String> receita;

  const EditRecipePage({super.key, required this.receita});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late TextEditingController _ingredientesController;
  late TextEditingController _preparoController;
  late TextEditingController _imagemController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.receita['titulo']);
    _descricaoController = TextEditingController(text: widget.receita['descricao']);
    _ingredientesController = TextEditingController(text: widget.receita['ingredientes']);
    _preparoController = TextEditingController(text: widget.receita['preparo']);
    _imagemController = TextEditingController(text: widget.receita['imagem']);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _ingredientesController.dispose();
    _preparoController.dispose();
    _imagemController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'titulo': _tituloController.text.trim(),
        'descricao': _descricaoController.text.trim(),
        'ingredientes': _ingredientesController.text.trim(),
        'preparo': _preparoController.text.trim(),
        'imagem': _imagemController.text.trim().isEmpty
            ? 'assets/default.jpg'
            : _imagemController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Receita')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe o título' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Informe a descrição'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ingredientesController,
                decoration: const InputDecoration(
                  labelText: 'Ingredientes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _preparoController,
                decoration: const InputDecoration(
                  labelText: 'Modo de Preparo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imagemController,
                decoration: const InputDecoration(
                  labelText: 'Caminho da imagem',
                  hintText: 'Ex.: assets/bolo.jpg',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
