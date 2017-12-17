CREATE TABLE IF NOT EXISTS currencies (
  id                          INTEGER PRIMARY KEY,
  name                        TEXT NOT NULL,
  code                        TEXT NOT NULL,
  num                         TEXT,
  digits_after_decimal        INTEGER NOT NULL,
  warehoused_at               TEXT NOT NULL,
  updated_at                  TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sources (
  id                          INTEGER PRIMARY KEY,
  name                        TEXT NOT NULL,
  details                     TEXT
);

CREATE TABLE IF NOT EXISTS counterparties (
  id                          INTEGER PRIMARY KEY,
  name                        TEXT NOT NULL,
  details                     TEXT,
  warehoused_at               TEXT NOT NULL,
  updated_at                  TEXT NOT NULL,
  source_id                   INTEGER NOT NULL,
  FOREIGN KEY(source_id) REFERENCES sources(id)
);

CREATE TABLE IF NOT EXISTS accounts (
  id                          INTEGER PRIMARY KEY,
  name                        TEXT NOT NULL,
  details                     TEXT,
  currency_id                 INTEGER NOT NULL,
  counterparty_id             INTEGER NOT NULL,
  warehoused_at               TEXT NOT NULL,
  updated_at                  TEXT NOT NULL,
  source_id                   INTEGER NOT NULL,
  FOREIGN KEY(currency_id) REFERENCES currencies(id),
  FOREIGN KEY(counterparty_id) REFERENCES counterparties(id),
  FOREIGN KEY(source_id) REFERENCES sources(id)
);

CREATE TABLE IF NOT EXISTS transactions (
  id                          INTEGER PRIMARY KEY,
  title                       TEXT NOT NULL,
  details                     TEXT,
  withdrawn_account_id        INTEGER NOT NULL,
  deposited_account_id        INTEGER NOT NULL,
  payment_amount              REAL NOT NULL,
  payment_currency_id         INTEGER NOT NULL,
  hold_amount                 REAL NOT NULL,
  transaction_amount          REAL,
  transactioned_at            TEXT NOT NULL,
  accounted_at                TEXT,
  warehoused_at               TEXT NOT NULL,
  updated_at                  TEXT NOT NULL,
  source_id                   INTEGER NOT NULL,
  FOREIGN KEY(withdrawn_account_id) REFERENCES accounts(id),
  FOREIGN KEY(deposited_account_id) REFERENCES accounts(id),
  FOREIGN KEY(payment_currency_id) REFERENCES currencies(id),
  FOREIGN KEY(source_id) REFERENCES sources(id)
);