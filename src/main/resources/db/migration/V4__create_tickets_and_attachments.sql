CREATE TABLE tickets (
    id           BIGSERIAL    PRIMARY KEY,
    title        VARCHAR(255) NOT NULL,
    description  TEXT,
    unit_id      BIGINT       NOT NULL REFERENCES units(id),
    type_id      BIGINT       NOT NULL REFERENCES ticket_types(id),
    status_id    BIGINT       NOT NULL REFERENCES ticket_statuses(id),
    creator_id   BIGINT       NOT NULL REFERENCES users(id),  -- sempre RESIDENT
    concluded_at TIMESTAMP,                                    -- preenchido ao mudar para status final
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP
);

CREATE INDEX idx_tickets_unit_id    ON tickets(unit_id);
CREATE INDEX idx_tickets_type_id    ON tickets(type_id);
CREATE INDEX idx_tickets_status_id  ON tickets(status_id);
CREATE INDEX idx_tickets_creator_id ON tickets(creator_id);
CREATE INDEX idx_tickets_created_at ON tickets(created_at DESC);

CREATE TABLE ticket_attachments (
    id                BIGSERIAL    PRIMARY KEY,
    ticket_id         BIGINT       NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename   VARCHAR(255) NOT NULL UNIQUE,  -- UUID + extensão; nome em disco
    content_type      VARCHAR(100),
    file_size         BIGINT,
    uploaded_at       TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ticket_attachments_ticket_id ON ticket_attachments(ticket_id);
