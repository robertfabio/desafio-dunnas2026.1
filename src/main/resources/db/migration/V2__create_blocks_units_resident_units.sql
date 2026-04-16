CREATE TABLE blocks (
    id              BIGSERIAL    PRIMARY KEY,
    name            VARCHAR(100) NOT NULL UNIQUE,
    floors          INTEGER      NOT NULL,
    units_per_floor INTEGER      NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP,
    CONSTRAINT chk_blocks_floors          CHECK (floors > 0),
    CONSTRAINT chk_blocks_units_per_floor CHECK (units_per_floor > 0)
);

CREATE TABLE units (
    id         BIGSERIAL   PRIMARY KEY,
    block_id   BIGINT      NOT NULL REFERENCES blocks(id) ON DELETE CASCADE,
    floor      INTEGER     NOT NULL,
    number     INTEGER     NOT NULL,
    identifier VARCHAR(50) NOT NULL UNIQUE,  -- ex: "A-101"
    created_at TIMESTAMP   NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_units_block_floor_number UNIQUE (block_id, floor, number),
    CONSTRAINT chk_units_floor  CHECK (floor > 0),
    CONSTRAINT chk_units_number CHECK (number > 0)
);

CREATE INDEX idx_units_block_id   ON units(block_id);
CREATE INDEX idx_units_identifier ON units(identifier);

-- Tabela de junção: morador ↔ unidas (N:N)
CREATE TABLE resident_units (
    resident_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    unit_id     BIGINT NOT NULL REFERENCES units(id) ON DELETE CASCADE,
    PRIMARY KEY (resident_id, unit_id)
);

CREATE INDEX idx_resident_units_unit_id ON resident_units(unit_id);
