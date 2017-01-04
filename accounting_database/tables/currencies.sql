CREATE TABLE IF NOT EXISTS accounting.currencies (
  id              UUID PRIMARY KEY,
  name            VARCHAR(255) NOT NULL,
  "desc"          VARCHAR(255) NOT NULL
);

ALTER TABLE accounting.currencies
    ADD COLUMN iso4217_code   CHARACTER(3) NOT NULL,
    ADD COLUMN iso4217_num    CHARACTER(3) NOT NULL;

ALTER TABLE accounting.currencies
    ADD CONSTRAINT unique_name UNIQUE(name),
    ADD CONSTRAINT unique_iso4217_code UNIQUE(iso4217_code),
    ADD CONSTRAINT unique_iso4217_num UNIQUE(iso4217_num);

ALTER TABLE accounting.currencies
    ADD COLUMN symbol   VARCHAR(32) NOT NULL;

ALTER TABLE accounting.currencies
    DROP COLUMN symbol;