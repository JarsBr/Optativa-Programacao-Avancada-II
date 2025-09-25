import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';
import 'settings_page.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<String> _titles = ['Doces', 'Salgadas', 'Bebidas', 'Favoritos'];

  // Lista de favoritos (vai guardar Map das receitas)
  final List<Map<String, String>> favoritos = [];

  // Listas de receitas
  final List<Map<String, String>> doces = [
    {
      'titulo': 'Bolo de Chocolate',
      'descricao': 'Um bolo fofinho e delicioso de chocolate.',
      'ingredientes': 'Farinha, ovos, açúcar, chocolate em pó, leite.',
      'preparo': 'Misture os ingredientes, asse por 40 minutos.'
    },
    {
      'titulo': 'Pudim de Leite',
      'descricao': 'Clássico pudim com calda de caramelo.',
      'ingredientes': 'Leite condensado, ovos, leite, açúcar.',
      'preparo': 'Bata, asse em banho-maria por 1 hora.'
    },
    {
      'titulo': 'Brigadeiro',
      'descricao': 'Docinho de festa amado por todos.',
      'ingredientes': 'Leite condensado, chocolate, manteiga.',
      'preparo': 'Cozinhe mexendo até desgrudar da panela.'
    },
  ];

  final List<Map<String, String>> salgadas = [
    {
      'titulo': 'Lasanha',
      'descricao': 'Camadas de massa, molho e queijo.',
      'ingredientes': 'Massa, molho de tomate, queijo, carne.',
      'preparo': 'Monte em camadas e leve ao forno por 30 min.'
    },
    {
      'titulo': 'Pizza Caseira',
      'descricao': 'Pizza rápida e saborosa feita em casa.',
      'ingredientes': 'Massa, molho, queijo, recheio a gosto.',
      'preparo': 'Asse em forno alto até dourar.'
    },
    {
      'titulo': 'Coxinha',
      'descricao': 'Salgado frito recheado com frango.',
      'ingredientes': 'Massa de batata, frango desfiado, farinha.',
      'preparo': 'Modele, empane e frite.'
    },
  ];

  final List<Map<String, String>> bebidas = [
    {
      'titulo': 'Suco de Laranja',
      'descricao': 'Refrescante e cheio de vitamina C.',
      'ingredientes': 'Laranjas frescas.',
      'preparo': 'Esprema e sirva gelado.'
    },
    {
      'titulo': 'Café Expresso',
      'descricao': 'Aquele café forte para acordar.',
      'ingredientes': 'Café moído, água.',
      'preparo': 'Prepare em cafeteira expresso.'
    },
    {
      'titulo': 'Vitamina de Banana',
      'descricao': 'Bebida saudável e nutritiva.',
      'ingredientes': 'Banana, leite, aveia, mel.',
      'preparo': 'Bata tudo no liquidificador.'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função para favoritar/desfavoritar
  void _toggleFavorite(Map<String, String> receita) {
    setState(() {
      if (favoritos.contains(receita)) {
        favoritos.remove(receita);
      } else {
        favoritos.add(receita);
      }
    });
  }

  // Função para montar lista de receitas
  Widget _buildRecipeList(List<Map<String, String>> receitas) {
    return ListView.builder(
      itemCount: receitas.length,
      itemBuilder: (context, index) {
        final receita = receitas[index];
        final isFavorite = favoritos.contains(receita);
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(receita['titulo']!),
            subtitle: Text(receita['descricao']!),
            trailing: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null),
              onPressed: () => _toggleFavorite(receita),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailPage(
                    titulo: receita['titulo']!,
                    descricao: receita['descricao']!,
                    ingredientes: receita['ingredientes']!,
                    preparo: receita['preparo']!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildRecipeList(doces),
      _buildRecipeList(salgadas),
      _buildRecipeList(bebidas),
      _buildRecipeList(favoritos),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Menu', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Doces',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Salgadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Bebidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
  ],
  currentIndex: _selectedIndex,
  onTap: _onItemTapped,
),
    );
  }
}
