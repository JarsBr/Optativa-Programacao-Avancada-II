# 📱 App de Receitas Favoritas

## 🎯 Objetivo
Desenvolver um aplicativo Flutter para gerenciar receitas, aplicando a navegação por abas e entre telas

Metodologia do app:
Imagine que você está criando um aplicativo de receitas. A experiência do usuário deve ser intuitiva, permitindo que ele explore diferentes categorias de pratos e salve seus favoritos.

---

## 📝 Descrição
O aplicativo simula um gerenciador de receitas onde o usuário pode:
- Navegar entre três categorias principais: **Doces**, **Salgadas** e **Bebidas**.
- Visualizar receitas representadas por **Cards**.
- Acessar os **detalhes completos** de cada receita (descrição, ingredientes e modo de preparo).
- **Favoritar** receitas, que ficam salvas em uma aba exclusiva chamada **Favoritos**.
- Acessar o menu lateral (**Drawer**) com opções para **Configurações** e **Sobre**.

---

## 🖼️ Estrutura do App
- **Tela Principal**  
  Navegação inferior com 4 abas: Doces, Salgadas, Bebidas e Favoritos.  

- **Cards de Receitas**  
  Cada card exibe o nome e descrição da receita.  
  Ao clicar, abre uma tela com os detalhes completos.  
  Possui botão de **coração** para favoritar.  

- **Tela de Detalhes**  
  Exibe título, descrição, lista de ingredientes e modo de preparo.  

- **Menu Lateral (Drawer)**  
  - Configurações 
  - Sobre