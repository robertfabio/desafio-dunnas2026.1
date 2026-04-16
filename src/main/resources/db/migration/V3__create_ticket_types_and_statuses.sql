CREATE TABLE ticket_types (
    id         BIGSERIAL    PRIMARY KEY,
    title      VARCHAR(255) NOT NULL UNIQUE,
    sla_hours  INTEGER      NOT NULL,  -- prazo máximo de resolução em horas
    active     BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP,
    CONSTRAINT chk_ticket_types_sla CHECK (sla_hours > 0)
);

CREATE TABLE ticket_statuses (
    id         BIGSERIAL    PRIMARY KEY,
    name       VARCHAR(100) NOT NULL UNIQUE,
    color      VARCHAR(7)   NOT NULL DEFAULT '#6c757d',  -- hex color para badge na UI
    is_default BOOLEAN      NOT NULL DEFAULT FALSE,       -- exatamente UM deve ser TRUE
    is_final   BOOLEAN      NOT NULL DEFAULT FALSE,       -- status de conclusão (gravar concluded_at)
    sort_order INTEGER      NOT NULL DEFAULT 0,
    created_at TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE INDEX idx_ticket_statuses_is_default ON ticket_statuses(is_default);
CREATE INDEX idx_ticket_types_active        ON ticket_types(active);
