# Backend para Gerenciamento de Gêneros

Este projeto é um backend desenvolvido em Delphi utilizando o framework Horse, destinado ao gerenciamento de gêneros (por exemplo, gêneros musicais, literários, etc.). Ele expõe uma API RESTful que permite criar, consultar, atualizar e deletar registros de gêneros em um banco de dados.

## Funcionalidades

- **Listar gêneros:** Retorna todos os gêneros cadastrados, com suporte a paginação e filtros.
- **Consultar gênero por ID:** Retorna os detalhes de um gênero específico a partir do seu identificador.
- **Criar gênero:** Permite cadastrar um novo gênero, gerando automaticamente um identificador único caso não seja informado.
- **Atualizar gênero:** Atualiza os dados de um gênero existente a partir do seu identificador.
- **Deletar gênero:** Remove um gênero do banco de dados pelo seu identificador.

## Tecnologias Utilizadas

- **Delphi**
- **Horse Framework**
- **JSON para comunicação**
- **Middleware para CORS, paginação e parsing de JSON**

## Estrutura

O código principal está localizado na pasta `src\Routers`, onde o arquivo `backend.Routers.Genres.pas` define as rotas e os controladores responsáveis pelas operações CRUD dos gêneros.

## Como executar

1. Abra o projeto no Delphi.
2. Compile e execute o servidor.
3. Acesse os endpoints REST conforme documentado nas rotas do arquivo de router.

---