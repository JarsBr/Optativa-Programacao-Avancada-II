import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  final String? initialCategory; // categoria sugerida (aba atual)

  const AddRecipePage({super.key, this.initialCategory});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _ingredientesController = TextEditingController();
  final _preparoController = TextEditingController();
  final _imagemController = TextEditingController(text: 'assets/default.jpg');

  static const _categorias = ['Doces', 'Salgadas', 'Bebidas'];
  String? _categoriaSelecionada;

  @override
  void initState() {
    super.initState();
    _categoriaSelecionada = _categorias.contains(widget.initialCategory)
        ? widget.initialCategory
        : _categorias.first;
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
        'categoria': _categoriaSelecionada!,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Receita')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _categoriaSelecionada,
                items: _categorias
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => _categoriaSelecionada = v),
              ),
              const SizedBox(height: 12),
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
                    ? 'Informe uma descrição'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ingredientesController,
                decoration: const InputDecoration(
                  labelText: 'Ingredientes',
                  hintText: 'Separe por vírgula ou por linhas',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Liste os ingredientes'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _preparoController,
                decoration: const InputDecoration(
                  labelText: 'Modo de Preparo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Descreva o modo de preparo'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imagemController,
                decoration: const InputDecoration(
                  labelText: 'Caminho da imagem (assets/...)',
                  hintText: 'Ex.: assets/bolo.jpg (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar receita'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
