INSERT INTO ticket_statuses (name, color, is_default, is_final, sort_order) VALUES
    ('Aberto',              '#0d6efd', TRUE,  FALSE, 1),
    ('Em Andamento',        '#ffc107', FALSE, FALSE, 2),
    ('Aguardando Morador',  '#fd7e14', FALSE, FALSE, 3),
    ('Concluído',           '#198754', FALSE, TRUE,  4),
    ('Cancelado',           '#dc3545', FALSE, TRUE,  5);

-- Tipo de chamado de exemplo
INSERT INTO ticket_types (title, sla_hours) VALUES
    ('Manutenção Geral',    48),
    ('Vazamento',           24),
    ('Área Comum',          72);

-- Usuário administrador padrão
-- Senha: Admin@123  (BCrypt strength=10)
INSERT INTO users (name, email, password_hash, role) VALUES
    ('Administrador',
     'admin@condominio.com',
     '$2a$10$P64fZrhwV1NeWVGW5b6FguAUiAiL3s3qnjVlMzf43Q6IoH7NshPAW',
     'ADMIN');
