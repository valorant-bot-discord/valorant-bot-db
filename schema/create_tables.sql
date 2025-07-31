CREATE TABLE mapas
(
    id_mapa          INT PRIMARY KEY,
    nome             VARCHAR(50) NOT NULL,
    quantidade_bombs INT         NOT NULL
);


CREATE TABLE calls
(
    id_calls                INT PRIMARY KEY,
    calls_descricao         VARCHAR(255) NOT NULL,
    quantidade_minima_bombs INT          NOT NULL,
    nome_bomb_especifico    VARCHAR(1)
);