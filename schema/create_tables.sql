-- Extensões Necessárias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Configuração de Fuso Horário
SET TIMEZONE TO 'America/Sao_Paulo';

-- ==================================================================================
-- Funções Utilitárias
-- ==================================================================================

-- Gera UUID para mapa usando UUID v5 com namespace fixo e nome do mapa
CREATE OR REPLACE FUNCTION gerar_uuid_mapa(nome_mapa TEXT)
    RETURNS UUID
    LANGUAGE plpgsql
    IMMUTABLE
AS
$$
BEGIN
    RETURN uuid_generate_v5(
            'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'::uuid, -- namespace fixo
            'valorant-bot-discord-mm-bot-2024-mapa' || nome_mapa
           );
END;
$$;

ALTER FUNCTION gerar_uuid_mapa(TEXT) OWNER TO postgres;

-- Gera UUID para calls com base na quantidade mínima de bombs e sigla
CREATE OR REPLACE FUNCTION gerar_uuid_call(
    quantidade_minima_bombs INT,
    sigla_bomb_especifico TEXT
)
    RETURNS UUID
    LANGUAGE plpgsql
    IMMUTABLE
AS
$$
DECLARE
    contexto TEXT;
BEGIN
    contexto := 'valorant-bot-discord-mm-bot-2024-calls-' ||
                quantidade_minima_bombs || '-' ||
                COALESCE(sigla_bomb_especifico, '') || '-' ||
                EXTRACT(EPOCH FROM CLOCK_TIMESTAMP())::TEXT;

    RETURN uuid_generate_v5(
            'a3e1f3c7-5a8d-47c1-90be-b0a9d34309b4'::uuid, -- namespace fixo
            contexto
           );
END;
$$;
-- ==================================================================================
-- Tabela de Mapas
-- ==================================================================================

-- Cria nova estrutura de mapas
CREATE TABLE tb_bot_valorant_mapas
(
    uuid_mapa_valorant_bot UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    uuid_mapa_valorant_api UUID UNIQUE,
    nome_mapa              VARCHAR(50) NOT NULL,
    quantidade_bombs       INT         NOT NULL,
    data_importacao_mapa   TIMESTAMPTZ      DEFAULT CURRENT_TIMESTAMP
);

-- Índices para performance
CREATE INDEX idx_mapas_nome ON tb_bot_valorant_mapas (nome_mapa);
CREATE INDEX idx_mapas_uuid_valorant_bot ON tb_bot_valorant_mapas (uuid_mapa_valorant_bot);

-- ==================================================================================
-- Tabela de Calls
-- ==================================================================================

-- Cria tabela de calls
CREATE TABLE tb_bot_valorant_calls
(
    uuid_calls              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    calls_descricao         VARCHAR(255) NOT NULL,
    quantidade_minima_bombs INT          NOT NULL,
    sigla_bomb_especifico   VARCHAR(1),
    data_criacao_call       TIMESTAMPTZ      DEFAULT CURRENT_TIMESTAMP
);

-- Índices para busca
CREATE INDEX idx_uuid_calls ON tb_bot_valorant_calls (uuid_calls);
CREATE INDEX idx_calls_descricao ON tb_bot_valorant_calls (calls_descricao);
