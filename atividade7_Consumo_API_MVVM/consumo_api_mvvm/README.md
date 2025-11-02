# Catálogo Online

Aplicativo Flutter que consome dados de uma API REST pública, aplicando o padrão **MVVM (Model–View–ViewModel)** para organizar o código e separar a lógica da interface. O app deve permitir visualizar uma lista de itens e exibir detalhes de um item selecionado.

---

## 📱 Descrição

O app exibe produtos obtidos da [Fake Store API](https://fakestoreapi.com/products).  
O usuário pode visualizar a lista de produtos e acessar uma página com informações detalhadas de cada item.

---

## 🧩 Estrutura MVVM

- **Model** → Representa o produto (`Product`)
- **Service** → Responsável pela comunicação com a API (`ProductService`)
- **ViewModel** → Faz a ponte entre a lógica e a interface (`ProductListViewModel`, `ProductDetailViewModel`)
- **View** → Telas que exibem os dados (`HomeView`, `ProductDetailView`)

---

## ⚙️ Funcionalidades

- Lista de produtos com imagem, nome e preço  
- Tela de detalhes com nome, descrição, preço, categoria e imagem  
- Indicador de carregamento enquanto os dados são obtidos  
- Mensagem de erro caso a API esteja inacessível  
- Navegação entre telas usando rotas nomeadas  

---