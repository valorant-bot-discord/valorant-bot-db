INSERT INTO calls (uuid_calls,
                   calls_descricao,
                   quantidade_minima_bombs,
                   sigla_bomb_especifico)
VALUES (gerar_uuid_call(2, 'A'), 'Vai bomb A', 2, 'A'),
       (gerar_uuid_call(2, 'B'), 'Vai bomb B', 2, 'B'),
       (gerar_uuid_call(3, 'C'), 'Vai bomb C', 3, 'C'),

       (gerar_uuid_call(2, 'A'), 'Dois tempos A', 2, 'A'),
       (gerar_uuid_call(2, 'B'), 'Dois tempos B', 2, 'B'),
       (gerar_uuid_call(3, 'C'), 'Dois tempos C', 3, 'C'),

       (gerar_uuid_call(2, 'A'), 'Fake A', 2, 'A'),
       (gerar_uuid_call(2, 'B'), 'Fake B', 2, 'B'),
       (gerar_uuid_call(3, 'C'), 'Fake C', 3, 'C'),

       (gerar_uuid_call(2, 'A'), 'APERTA O W NO BOMB A', 2, 'A'),
       (gerar_uuid_call(2, 'B'), 'APERTA O W NO BOMB B', 2, 'B'),

       (gerar_uuid_call(0, NULL), 'Vai Geral Meio', 0, NULL),
       (gerar_uuid_call(0, NULL), 'Sacrifica a PISTOLA', 0, NULL),
       (gerar_uuid_call(0, NULL), 'SHIFT até 30s', 0, NULL),
       (gerar_uuid_call(3, NULL), 'Rotação rápida', 3, NULL);
