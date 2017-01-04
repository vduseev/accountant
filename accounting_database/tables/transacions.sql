CREATE TABLE IF NOT EXISTS accounting.transactions (
  id            UUID PRIMARY KEY,
  "from"        UUID NOT NULL
    REFERENCES accounting.accounts(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  "to"          UUID NOT NULL
    REFERENCES accounting.accounts(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  currency_id   UUID NOT NULL
    REFERENCES accounting.currencies(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  amount        REAL NOT NULL,
  "desc"        TEXT
);

ALTER TABLE accounting.transactions
    RENAME COLUMN "from" TO from_id;

ALTER TABLE accounting.transactions
    RENAME COLUMN "to" TO to_id;

ALTER TABLE accounting.transactions
    ALTER COLUMN amount SET DATA TYPE MONEY USING amount::REAL::NUMERIC::MONEY;

ALTER TABLE accounting.transactions
    ADD COLUMN timestamp TIMESTAMPTZ NOT NULL;