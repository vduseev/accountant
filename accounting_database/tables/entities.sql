CREATE TABLE IF NOT EXISTS accounting.entities (
  id              UUID PRIMARY KEY,
  name            VARCHAR(255) NOT NULL,
  country         VARCHAR(255) NOT NULL,
  city            VARCHAR(255) NOT NULL,
  address         VARCHAR(255) NOT NULL,
  legal_name      VARCHAR(255) NOT NULL,
  legal_address   VARCHAR(255) NOT NULL
);