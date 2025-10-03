# 📱 App de Receitas Favoritas V2

# Atividade 5: Ampliar o aplicativo de receitas, permitindo que o usuário clique em uma receita e visualize uma página dedicada com informações completas

## Descrição
Este projeto consiste em um aplicativo Flutter para gerenciamento de receitas, que foi ampliado a partir de uma versão inicial simples.  
O aplicativo permite que o usuário navegue entre categorias de receitas, visualize detalhes completos de cada prato, insira novas receitas, edite receitas existentes e remova itens da lista.

---

## Requisitos Implementados

### Navegação por abas (BottomNavigationBar)
- O aplicativo possui 3 categorias fixas:
  - Doces
  - Salgadas
  - Bebidas
- Cada categoria exibe uma lista de receitas correspondentes.

### Lista de receitas por categoria
- As receitas são exibidas em **Cards**, cada um contendo:
  - Título da receita
  - Ícone ilustrativo (miniatura da imagem)
  - Descrição resumida (subtítulo em 1 linha)

### Navegação para tela de detalhes
- Ao tocar em um Card, o usuário é direcionado para uma nova página.
- A tela de detalhes exibe:
  - Título da receita (na AppBar e no corpo)
  - Imagem ilustrativa
  - Descrição completa
  - Lista de ingredientes
  - Modo de preparo
  - Botão de voltar

### Inserir nova receita
- Um botão flutuante (FAB) na tela principal permite abrir um formulário de cadastro.
- O formulário inclui:
  - Categoria
  - Título
  - Descrição
  - Ingredientes
  - Modo de preparo
  - Caminho da imagem
- Ao salvar, a nova receita é adicionada à categoria escolhida.

### Editar receita existente
- Dentro da tela de detalhes, há um botão de edição.
- Ao clicar, abre-se uma tela de formulário já preenchida com os dados da receita.
- É possível alterar os campos e salvar as modificações.

### Remover receita
- Cada Card pode ser removido ao deslizar para o lado (Dismissible).
- Ao excluir, é exibido um SnackBar com a opção de desfazer a ação.