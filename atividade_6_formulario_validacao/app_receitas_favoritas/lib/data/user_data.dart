class User {
  final String nome;
  final String email;
  final String senha;

  User({
    required this.nome,
    required this.email,
    required this.senha,
  });
}

// "Banco de dados" local (em memória)
List<User> usuarios = [];
