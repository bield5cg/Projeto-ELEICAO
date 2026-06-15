-- ==========================================
-- SISTEMA DE GERENCIAMENTO DE ELEIÇÕES
-- MariaDB (XAMPP)
-- Autor: Gabriel Lindolfo
-- ==========================================

-- ==========================================
-- CRIAÇÃO DO BANCO DE DADOS
-- ==========================================

CREATE DATABASE ELEICAO;

USE ELEICAO;

-- ==========================================
-- CRIAÇÃO DAS TABELAS
-- ==========================================

CREATE TABLE partido (
id_partido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
sigla VARCHAR(10) NOT NULL
);

CREATE TABLE candidato (
id_candidato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
numero INT UNIQUE NOT NULL,
cargo VARCHAR(50) NOT NULL,
id_partido INT NOT NULL
);

ALTER TABLE candidato
ADD CONSTRAINT fk_partido_candidato
FOREIGN KEY (id_partido)
REFERENCES partido(id_partido);

CREATE TABLE eleitor (
id_eleitor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(14) UNIQUE NOT NULL,
titulo_eleitor VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE eleicao (
id_eleicao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
descricao VARCHAR(100) NOT NULL,
data_eleicao DATE NOT NULL
);

CREATE TABLE voto (
id_voto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
data_hora DATETIME NOT NULL,
id_eleitor INT NOT NULL,
id_candidato INT NOT NULL,
id_eleicao INT NOT NULL
);

ALTER TABLE voto
ADD CONSTRAINT fk_eleitor_voto
FOREIGN KEY (id_eleitor)
REFERENCES eleitor(id_eleitor);

ALTER TABLE voto
ADD CONSTRAINT fk_candidato_voto
FOREIGN KEY (id_candidato)
REFERENCES candidato(id_candidato);

ALTER TABLE voto
ADD CONSTRAINT fk_eleicao_voto
FOREIGN KEY (id_eleicao)
REFERENCES eleicao(id_eleicao);

-- Regra: um eleitor pode votar apenas uma vez por eleição

ALTER TABLE voto
ADD CONSTRAINT uk_eleitor_eleicao
UNIQUE (id_eleitor, id_eleicao);

-- ==========================================
-- INSERÇÃO DOS DADOS
-- ==========================================

INSERT INTO partido (nome, sigla)
VALUES
('Uniao_Democratica_popular', 'UDP'),
('Partido_futuro_sustentavel', 'PFS'),
('Alianca_Verde_Nacional', 'AVN'),
('Movimento_Trabalhista_Popular', 'MTP');

INSERT INTO candidato (nome, numero, cargo, id_partido)
VALUES
('Lucas_Almeida', 15111, 'Vereador', 1),
('Mariana_Costa', 25222, 'Vereadora', 2),
('Rafael_Martins', 15, 'Prefeito', 3),
('Beatriz_Oliveira', 25, 'Prefeita', 4);

INSERT INTO eleicao (descricao, data_eleicao)
VALUES
('Eleições Municipais', '2026-10-04');

INSERT INTO eleitor (nome, cpf, titulo_eleitor)
VALUES
('Joao_pereira','12345678912','123456789012'),
('Ana_souza','23456789012','234567890123'),
('Carlos_oliveira','34567890123','345678901234'),
('Fernanda_lima','45678901234','456789012345'),
('Ricardo_Santos','56789012345','567890123456'),
('Juliana_rocha','67890123456','678901234567'),
('Gustavo_almeida','78901234567','789012345678'),
('Camila_ferreira','89012345678','890123456789'),
('Marcelo_costa','90123456789','901234567890'),
('Patricia_martins','01234567890','012345678901');

INSERT INTO voto (data_hora, id_candidato, id_eleitor, id_eleicao)
VALUES
('2026-10-04 09:45:13', 1, 2, 1),
('2026-10-04 12:37:23', 3, 1, 1),
('2026-10-04 10:32:00', 1, 3, 1),
('2026-10-04 13:30:40', 4, 10, 1),
('2026-10-04 13:30:40', 2, 7, 1),
('2026-10-04 09:17:12', 3, 5, 1),
('2026-10-04 08:22:03', 1, 4, 1),
('2026-10-04 16:02:21', 2, 6, 1),
('2026-10-04 08:00:07', 3, 9, 1),
('2026-10-04 11:25:10', 4, 8, 1);

-- ==========================================
-- CONSULTAS
-- ==========================================

-- Candidatos e Partidos

SELECT
c.nome AS candidato,
p.nome AS partido,
p.sigla
FROM candidato c
INNER JOIN partido p
ON c.id_partido = p.id_partido;

-- Relatório Geral da Eleição

SELECT
v.id_voto,
e.nome AS eleitor,
c.nome AS candidato,
p.nome AS partido,
p.sigla,
el.descricao AS eleicao,
v.data_hora
FROM voto v
INNER JOIN eleitor e
ON v.id_eleitor = e.id_eleitor
INNER JOIN candidato c
ON v.id_candidato = c.id_candidato
INNER JOIN partido p
ON c.id_partido = p.id_partido
INNER JOIN eleicao el
ON v.id_eleicao = el.id_eleicao;

-- Apuração dos Votos

SELECT
c.nome AS candidato,
p.sigla,
COUNT(v.id_voto) AS total_votos
FROM candidato c
INNER JOIN partido p
ON c.id_partido = p.id_partido
LEFT JOIN voto v
ON c.id_candidato = v.id_candidato
GROUP BY c.id_candidato, c.nome, p.sigla
ORDER BY total_votos DESC;
