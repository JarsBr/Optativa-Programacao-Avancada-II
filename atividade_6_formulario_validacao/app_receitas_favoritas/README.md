# 📱 App de Receitas Favoritas V3

# Atividade 6: Ampliar o aplicativo de receitas com autenticação simples, formulários com validação e navegação por abas

## Descrição
Este projeto consiste em uma ampliação do aplicativo Flutter de gerenciamento de receitas, adicionando autenticação de usuário, validação de formulários e melhorias na navegação e gerenciamento das receitas.  
O aplicativo agora permite que o usuário se cadastre, faça login e gerencie receitas divididas em categorias (Doces, Salgadas e Bebidas), tudo de forma local, sem uso de banco de dados externo.

---

## Requisitos Implementados

### Autenticação Local (sem persistência)
- O sistema permite **login** e **cadastro de usuários**, armazenando os dados em uma lista local dentro do código.
- Cada usuário possui os campos:
  - Nome
  - E-mail
  - Senha
- Durante o **cadastro**, o sistema valida os campos:
  - Nome obrigatório
  - E-mail deve ter formato válido
  - Senha deve ter pelo menos 6 caracteres
- Caso o e-mail já esteja cadastrado, o sistema impede o registro duplicado.
- No **login**, o app verifica se o e-mail e senha correspondem a um usuário existente.
- Ao entrar com sucesso, o usuário é redirecionado à tela principal.
- O menu lateral (Drawer) contém a opção **Sair**, que encerra a sessão e retorna à tela de login.

---

### Tela Principal – Receitas por Categorias
- A navegação entre categorias é feita através de um **BottomNavigationBar** com três abas:
  - Doces
  - Salgadas
  - Bebidas
- Cada aba exibe uma lista de receitas pertencentes àquela categoria.

---

### Lista de Receitas
- Cada receita é exibida em um **Card** contendo:
  - Nome da receita
  - Descrição curta (subtítulo)
  - Tempo de preparo (em minutos)
  - Imagem ilustrativa
  - Botão de ação para visualizar detalhes
- O usuário pode deslizar o Card para remover uma receita (função **Dismissible**).
- Ao remover, o sistema exibe um **SnackBar** com opção de desfazer.

---

### Cadastro e Edição de Receitas
- Um botão flutuante (**FloatingActionButton**) na tela principal abre o formulário de cadastro de receitas.
- Campos obrigatórios:
  - Nome da receita
  - Descrição curta
  - Tempo de preparo (número positivo)
  - Categoria (Doces, Salgadas ou Bebidas)
- O formulário realiza validação em todos os campos antes de salvar.
- A nova receita é automaticamente adicionada na aba correspondente.
- A tela de detalhes permite **editar** receitas existentes com os dados previamente preenchidos.