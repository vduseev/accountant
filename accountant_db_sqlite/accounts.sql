CREATE TABLE IF NOT EXISTS accounting.accounts (
  id              UUID PRIMARY KEY,
  name            VARCHAR(255) NOT NULL,
  "desc"          TEXT NOT NULL,
  entity_id       UUID NOT NULL
    REFERENCES accounting.entities(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  currency_id     UUID NOT NULL
    REFERENCES accounting.currencies(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  balance         REAL NOT NULL
);