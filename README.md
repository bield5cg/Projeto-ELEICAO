# Sistema de Gerenciamento de Eleições
Projeto desenvolvido para a disciplina de Banco de Dados com o objetivo de modelar e implementar um sistema de votação eletrônica utilizando bancos de dados relacionais.

O sistema permite o cadastro de partidos políticos, candidatos, eleitores, eleições e votos, além da realização da apuração automática dos resultados.

Posteriormente, o projeto foi migrado do MariaDB para o Supabase (PostgreSQL), demonstrando a adaptação da estrutura entre diferentes Sistemas Gerenciadores de Banco de Dados.

# Sobre o Projeto
O projeto foi desenvolvido para simular um processo eleitoral completo, armazenando informações dos participantes e garantindo a integridade dos dados através de relacionamentos entre tabelas.

Durante o desenvolvimento foram aplicados conceitos como:

Modelagem Conceitual (MER)
Modelagem Lógica (DER)
Cardinalidade
Chaves Primárias
Chaves Estrangeiras
Integridade Referencial
Consultas SQL
Apuração de Resultados

<img width="1361" height="791" alt="Image" src="https://github.com/user-attachments/assets/2af0116c-469b-44cc-88fb-79307443cbac" />

<img width="1304" height="686" alt="Image" src="https://github.com/user-attachments/assets/0302ada1-8aee-41f9-8f11-c81e23f8bd12" />

# Estrutura do Banco de Dados

O sistema é composto por cinco entidades principais:

## Partido
Armazena os partidos políticos cadastrados no sistema.

## Candidato
Armazena os candidatos participantes das eleições.

## Eleitor
Armazena os dados dos eleitores aptos a votar.

## Eleição
Armazena as eleições cadastradas.

## Voto
Armazena os votos realizados e conecta as informações de eleitor, candidato e eleição.

# Relacionamentos

Relacionamento	      

Partido        →        Candidato	1

Candidato      →         Voto 1

Eleitor        →         Voto	1

Eleição        →         Voto	1

## Regra Principal

Um eleitor pode votar apenas uma vez por eleição.

Essa regra foi implementada através da restrição:

UNIQUE(id_eleitor, id_eleicao)

# Tecnologias Utilizadas

### Banco de Dados

MariaDB
PostgreSQL (Supabase)

### Linguagem

SQL

### Ferramentas

XAMPP

Supabase

Git

GitHub

# Como Executar o Projeto

## 1 - Criar o banco de dados

CREATE DATABASE ELEICAO;

## 2 - Executar os scripts de criação

Execute os comandos de criação das tabelas.

## 3 - Inserir os dados

Execute os comandos INSERT presentes no projeto.

## 4 - Realizar consultas

Execute os scripts de consultas para:

Visualizar candidatos e partidos;

Consultar os votos registrados;

Realizar a apuração da eleição.

# Consultas Implementadas
### Consulta de Candidatos e Partidos

Relaciona os candidatos aos respectivos partidos.

### Consulta Geral da Eleição

Apresenta:

Eleitor;

Candidato;

Partido;

Sigla;

Eleição;

Data e horário do voto.

### Apuração dos Votos

Conta os votos recebidos por cada candidato e exibe o resultado em ordem decrescente.

# Migração para Supabase

Após a implementação no MariaDB, o projeto foi adaptado para o Supabase utilizando PostgreSQL.

Durante a migração foram realizados ajustes de sintaxe, principalmente na geração automática das chaves primárias.

### MariaDB

"AUTO_INCREMENT"

### PostgreSQL / Supabase

"SERIAL"

As demais estruturas permaneceram praticamente iguais, demonstrando a compatibilidade entre os bancos de dados relacionais.

## Restrição de Voto Único

Foi necessário garantir que um eleitor não pudesse votar mais de uma vez na mesma eleição.

Solução: Implementação da restrição:

"UNIQUE(id_eleitor, id_eleicao)"

## Migração para Supabase

Alguns comandos utilizados no MariaDB não possuíam a mesma sintaxe no PostgreSQL.

Solução: Adaptação dos scripts utilizando a documentação oficial do PostgreSQL

# Aprendizados

Durante o desenvolvimento deste projeto foram praticados conceitos importantes de Banco de Dados:

Modelagem de Dados

Normalização

Cardinalidade

Integridade Referencial

SQL

JOIN

GROUP BY

COUNT

PostgreSQL

Supabase


## Autor

Gabriel Lindolfo

Projeto acadêmico desenvolvido para fins de estudo da disciplina de Banco de Dados.



