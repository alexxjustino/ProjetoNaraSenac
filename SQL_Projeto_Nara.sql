CREATE DATABASE projeto_Nara;

USE projeto_Nara;

CREATE TABLE hoteis (
id             INT PRIMARY KEY,
nome_hotel     VARCHAR(100),
cidade         VARCHAR(100),
estado         VARCHAR(100),
categoria      VARCHAR(100),
n_quartos      INT
);

CREATE TABLE hospedes (
id               INT PRIMARY KEY,
nome             VARCHAR(100),
email            VARCHAR(100),
telefone         VARCHAR(100),
cidade_origem    VARCHAR(100),
estado           INT,
data_nascimento  DATE,
genero           VARCHAR(100)
);

CREATE TABLE quartos (
id_quarto      VARCHAR(100) PRIMARY KEY,
id_hotel       INT,
tipo_quarto    VARCHAR(100),
capacidade     INT,
valor_base     DECIMAL(10,2),
andar          INT,
vista          VARCHAR(100),
FOREIGN KEY (id_hotel) REFERENCES hoteis (id)
);

CREATE TABLE reservas (
id               INT PRIMARY KEY,
id_hospede       INT,
id_quarto        VARCHAR(100),
id_hotel         INT,
data_checkin     DATE,
data_checkout    DATE,
canal_reserva    VARCHAR(100),
valor_diaria     DECIMAL(10,2),
status_reserva   VARCHAR(100),
data_reserva     DATE,
FOREIGN KEY (id_hotel) REFERENCES hoteis (id),
FOREIGN KEY (id_hospede) REFERENCES hospedes (id));

CREATE TABLE avaliacoes (
id                    INT PRIMARY KEY,
id_reserva            INT,
nota_geral            DECIMAL(10,2),
nota_limpeza          DECIMAL(10,2),
nota_atendimento      DECIMAL(10,2),
nota_custo_beneficio  INT,
comentario            VARCHAR(100),
data_avaliacao        DATE
);

SET GLOBAL local_infile = 1;

LOAD DATA INFILE "C:/Users/Arthur Martins/Desktop/Pyton/hoteis.csv"
INTO TABLE hoteis
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, nome_hotel, cidade, estado, categoria, n_quartos);

LOAD DATA INFILE "C:/Users/Arthur Martins/Desktop/Pyton/hospedes.csv"
IGNORE
INTO TABLE hospedes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, nome, email, telefone, cidade_origem, estado, data_nascimento, genero
);

LOAD DATA INFILE "C:/Users/Arthur Martins/Desktop/Pyton/quartos.csv"
INTO TABLE quartos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_quarto,	id_hotel, tipo_quarto, capacidade, valor_base, andar, vista
);

LOAD DATA INFILE "C:/Users/Arthur Martins/Desktop/Pyton/reservas.csv"
INTO TABLE reservas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, id_hospede, id_quarto,	id_hotel, data_checkin,	data_checkout, canal_reserva, valor_diaria,	status_reserva,	data_reserva
);

LOAD DATA INFILE "C:/Users/Arthur Martins/Desktop/Pyton/avaliacoes.csv"
INTO TABLE avaliacoes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, id_reserva, nota_geral, nota_limpeza, nota_atendimento, nota_custo_beneficio, comentario, data_avaliacao
);
