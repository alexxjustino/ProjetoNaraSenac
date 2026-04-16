CREATE DATABASE Projeto_Nara;
USE Projeto_Nara;

CREATE TABLE hoteis (
id_hotel INT PRIMARY KEY,
nome_hotel VARCHAR (50),
cidade VARCHAR (50),
estado VARCHAR (2),
categoria VARCHAR (50),
n_quartos INT
); 

CREATE TABLE quartos (
id_quarto INT PRIMARY KEY,
id_hotel INT,
tipo_quarto VARCHAR (50),
capacidade DECIMAL(10,1),
valor_base DECIMAL (10,1),
andar INT,
vista VARCHAR (50)
);

CREATE TABLE hospedes (
id_hospede INT PRIMARY KEY,
nome  VARCHAR (50),
email  VARCHAR (50),
telefone  VARCHAR (50),
cidade_origem  VARCHAR (50),
estado  VARCHAR (2),
data_nascimento VARCHAR (50),
genero  VARCHAR (10)
);

CREATE TABLE avaliacoes (
id_avaliacao INT PRIMARY KEY,
id_reserva INT,
nota_geral DECIMAL (10,1),
nota_limpeza DECIMAL (10,1),
nota_atendimento DECIMAL (10,1),
nota_custo_beneficio DECIMAL (10,1),
comentario VARCHAR (150),
data_avaliacao DATE
);

CREATE TABLE reservas (
id_reserva INT PRIMARY KEY,
id_hospede INT,
id_quarto INT,
id_hotel INT,
data_checkin DATE,
data_checkout DATE,
canal_reserva VARCHAR (50),
valor_diaria DECIMAL (10,2),
status_reserva VARCHAR (50),
data_reserva DATE,
FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto),
FOREIGN KEY (id_hotel) REFERENCES hoteis(id_hotel)
);

SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'D:/documentos/ProjetoNaraSenac_SQL/hoteis_tratado.csv'
INTO TABLE hoteis
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id_hotel,nome_hotel,cidade,estado,categoria,n_quartos);
SELECT * FROM hoteis;


LOAD DATA INFILE 'D:/documentos/ProjetoNaraSenac_SQL/quartos_tratado.csv'
INTO TABLE quartos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_quarto,id_hotel,tipo_quarto,capacidade,valor_base,andar,vista);

LOAD DATA INFILE 'D:/documentos/ProjetoNaraSenac_SQL/hospedes_tratado.csv'
INTO TABLE hospedes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_hospede,nome,email,telefone,cidade_origem,estado,data_nascimento,genero);

LOAD DATA INFILE 'D:/documentos/ProjetoNaraSenac_SQL/avaliacoes_tratado.csv'
INTO TABLE avaliacoes
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id_avaliacao,id_reserva,nota_geral,nota_limpeza,nota_atendimento,nota_custo_beneficio,comentario,data_avaliacao);

LOAD DATA INFILE 'D:/documentos/ProjetoNaraSenac_SQL/reservas_tratado.csv'
INTO TABLE reservas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_reserva,id_hospede,id_quarto,id_hotel,data_checkin,data_checkout,canal_reserva,valor_diaria,status_reserva,data_reserva);

# C1 - RECEITA POR UNIDADE
# 1. Com outliers
SELECT hoteis.nome_hotel, SUM(reservas.valor_diaria) AS receita_total
FROM reservas
JOIN hoteis ON reservas.id_hotel = hoteis.id_hotel
GROUP BY hoteis.nome_hotel
ORDER BY receita_total
DESC;

# 2. Excluindo outliers
SELECT hoteis.nome_hotel, sum(reservas.valor_diaria) as receita_total
FROM reservas
JOIN hoteis ON reservas.id_hotel = hoteis.id_hotel
WHERE reservas.valor_diaria < 4102.12
GROUP BY hoteis.nome_hotel
ORDER BY receita_total
DESC;

# C2 - HÓSPEDES DE ALTO VALOR
# para definir alto valor contei quantas reservas o hospedes fez com a rede e somei o valor das diárias
SELECT hospedes.id_hospede, hospedes.nome, COUNT(reservas.id_reserva) AS total_reserva, SUM(reservas.valor_diaria) AS total_receita
FROM reservas
JOIN hospedes ON reservas.id_hospede = hospedes.id_hospede
WHERE reservas.status_reserva = 'Confirmada'
GROUP BY hospedes.id_hospede, hospedes.nome
ORDER BY total_receita
DESC
LIMIT 5;

#C3 - HOSPEDES SEM AVALIAÇÃO
# como a tabela avaliacao se relaciona apenas com reserva que tb é fato, vou separar a resolução
# 1. Identificando as reservas que estão sem comentários
SELECT id_reserva, comentario FROM avaliacoes
WHERE comentario iS NULL OR comentario = '';

# 2. Correlacionando cada id_reserva na tabela reservas com o nome do cliente na tabela hospedes
SELECT hospedes.id_hospede, hospedes.nome, COUNT(reservas.id_hospede) AS total_reserva
FROM reservas
JOIN hospedes ON reservas.id_hospede = hospedes.id_hospede
WHERE reservas.id_reserva IN (204, 81, 564, 896, 139, 382, 598, 733, 588, 651, 794, 568, 898, 417, 442, 150, 385, 403, 834, 457, 512, 560, 800, 581, 162, 282, 760, 103, 357, 513, 914, 609, 156, 650, 366, 880, 958, 137, 443, 872, 527, 837, 188, 795, 700, 129, 839, 1, 396, 506, 725, 214, 1293, 1464, 1339, 1066, 1386, 1471, 1227, 1426, 1018, 1336, 1085, 1384, 1288, 1251, 1165, 1030, 1110, 1373, 1344, 1486)
GROUP BY hospedes.id_hospede, hospedes.nome
ORDER BY total_reserva
DESC;

# C4 - CANAIS COM MAIS RESERVAS
# 1. canais com maior volume de reservas
SELECT canal_reserva, COUNT(id_reserva) AS total_reserva
FROM reservas
GROUP BY canal_reserva
ORDER BY total_reserva
DESC;

# 2. canais com maior ticket médio
SELECT canal_reserva, ROUND(AVG(valor_diaria),2) AS ticket_medio
FROM reservas
GROUP BY canal_reserva
ORDER BY ticket_medio
DESC;

# C5 - OVERBOOKING POR MÊS/HOTEL
# 1. overbooking por hotel
SELECT hoteis.nome_hotel, COUNT(reservas.status_reserva) AS overbooking
FROM reservas
JOIN hoteis ON reservas.id_hotel = hoteis.id_hotel
WHERE reservas.status_reserva = 'Overbooking'
GROUP BY hoteis.nome_hotel
ORDER BY overbooking
DESC;

# 2. overbooking por mês
SELECT hoteis.nome_hotel, reservas.status_reserva, DATE_FORMAT(data_checkin, '%Y-%m') AS mes_ano
FROM reservas
JOIN hoteis ON reservas.id_hotel = hoteis.id_hotel
WHERE reservas.status_reserva = 'Overbooking'
ORDER BY mes_ano
DESC;

# C6 - RESERVAS CANCELADAS COM MENOS DE 7 DIAS COM HOTEL E CANAL DE ORIGEM
# não temos a data de cancelamento, portanto não é possível fazer a consulta.
# consultei o volume de reservas canceladas por hotel
SELECT hoteis.nome_hotel, COUNT(reservas.status_reserva) AS reservas_canceladas
FROM reservas
JOIN hoteis ON reservas.id_hotel = hoteis.id_hotel
WHERE reservas.status_reserva = 'Cancelada'
GROUP BY hoteis.nome_hotel
ORDER BY reservas_canceladas
DESC;

# C7 - HOSPEDES COM HISTÓRICO DE NO-SHOW
SELECT hospedes.nome, COUNT(reservas.status_reserva) AS hosp_noshow
FROM reservas
JOIN hospedes ON reservas.id_hospede = hospedes.id_hospede
WHERE reservas.status_reserva = 'No-show'
GROUP BY hospedes.nome
ORDER BY hosp_noshow
DESC;


