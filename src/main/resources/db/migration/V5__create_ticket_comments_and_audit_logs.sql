CREATE TABLE ticket_comments (
    id         BIGSERIAL  PRIMARY KEY,
    ticket_id  BIGINT     NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    author_id  BIGINT     NOT NULL REFERENCES users(id),
    content    TEXT       NOT NULL,
    created_at TIMESTAMP  NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE INDEX idx_ticket_comments_ticket_id ON ticket_comments(ticket_id);
CREATE INDEX idx_ticket_comments_author_id ON ticket_comments(author_id);

CREATE TABLE audit_logs (
    id          BIGSERIAL    PRIMARY KEY,
    user_id     BIGINT,                    -- NULL para ações automáticas do sistema
    user_email  VARCHAR(255),              -- desnormalizado: preserva histórico mesmo se user deletado
    action      VARCHAR(100) NOT NULL,     -- ex: TICKET_CREATED, STATUS_UPDATED
    entity_type VARCHAR(100) NOT NULL,     -- ex: Ticket, Block, User
    entity_id   BIGINT,
    details     TEXT,                      -- JSON livre com contexto adicional
    ip_address  VARCHAR(45),
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_audit_logs_user_id     ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_entity      ON audit_logs(entity_type, entity_id);
CREATE INDEX idx_audit_logs_created_at  ON audit_logs(created_at DESC);
