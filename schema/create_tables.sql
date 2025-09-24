-- Garantir que a extensão uuid-ossp esteja disponível
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==================================================================================
-- Tabela de funções (deve ser criada primeiro devido à referência de foreign key)
-- ==================================================================================

-- Cria tabela de funções
CREATE TABLE tb_bot_valorant_funcoes_agentes
(
    id   UUID DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    nome VARCHAR(50)                    NOT NULL UNIQUE
);

-- ==================================================================================
-- Tabela de Mapas
-- ==================================================================================

-- Cria nova estrutura de mapas
CREATE TABLE tb_bot_valorant_mapas
(
    uuid_mapa_valorant_bot UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    uuid_mapa_valorant_api UUID UNIQUE,
    nome_mapa              VARCHAR(100)                                                                  NOT NULL,
    quantidade_bombs       INT                                                                           NOT NULL,
    data_importacao_mapa   TIMESTAMP        DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'America/Sao_Paulo') NOT NULL
);

-- Índices para busca
CREATE INDEX idx_mapas_nome ON tb_bot_valorant_mapas (nome_mapa);
CREATE INDEX idx_mapas_uuid_valorant_bot ON tb_bot_valorant_mapas (uuid_mapa_valorant_bot);

-- ==================================================================================
-- Tabela de Calls
-- ==================================================================================

-- Cria tabela de calls
CREATE TABLE tb_bot_valorant_calls
(
    uuid_calls              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    calls_descricao         VARCHAR(255)                                                                  NOT NULL,
    quantidade_minima_bombs INT                                                                           NOT NULL,
    sigla_bomb_especifico   VARCHAR(1),
    data_criacao_call       TIMESTAMP        DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'America/Sao_Paulo') NOT NULL
);

-- Índices para busca
CREATE INDEX idx_uuid_calls ON tb_bot_valorant_calls (uuid_calls);
CREATE INDEX idx_calls_descricao ON tb_bot_valorant_calls (calls_descricao);

-- Constraint para validar sigla_bomb_especifico
ALTER TABLE tb_bot_valorant_calls
    ADD CONSTRAINT check_sigla_bomb
        CHECK (sigla_bomb_especifico IN ('A', 'B', 'C') OR sigla_bomb_especifico IS NULL);

-- ==================================================================================
-- Tabela de Agentes
-- ==================================================================================

-- Cria tabela de agentes
CREATE TABLE tb_bot_valorant_agentes
(
    uuid_agente_valorant_bot UUID      DEFAULT gen_random_uuid()                                    NOT NULL PRIMARY KEY,
    uuid_agente_valorant_api UUID,
    nome_agente              VARCHAR(100)                                                           NOT NULL UNIQUE,
    id_funcao_agente         UUID                                                                   NOT NULL
        CONSTRAINT fk_funcao
            REFERENCES tb_bot_valorant_funcoes_agentes (id),
    criado_em                TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'America/Sao_Paulo') NOT NULL
);

-- Índices para busca
CREATE INDEX idx_agente_uuid_valorant_bot ON tb_bot_valorant_agentes (uuid_agente_valorant_bot);
CREATE INDEX idx_agente_nome ON tb_bot_valorant_agentes (nome_agente);
CREATE INDEX idx_agente_funcao ON tb_bot_valorant_agentes (id_funcao_agente);