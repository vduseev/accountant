# The Accountant
Multiplatform accounting software synchronized via cloud.

## Highlights
* [ ] Custom data importers from ING and Tinkoff

## Development Plan
* [x] Prototype database scheme using Google Sheets *(Done 12/02/17)*
  * [x] Accounts, Transactions, Currencies
    * [ ] You can always optimize later for more tables
* [ ] Describe design alternatives
  * [ ] Use Google Sheets as DB backend
  * [ ] Use Firestore NoSQL storage
  * [ ] Use SQL database hosted somewhere
    * [ ] Use auto-increment IDs instead of GUIDs
      * [ ] You can always switch to GUIDs later
    * [ ] Use SQLite DB for prototyping locally
    * [ ] After nice testing move data to remote DB
    * [ ] Use MySQL/PostgreSQL hosted on VPS
      * [ ] Regular backups to some location
    * [ ] Use Amazon's $10 PostgreSQL
* Lay out REST API to work with database
  * [x] Install Swagger Editor *(Done 12/04/17)*
  * Study OpenAPI 3.0.0 specification *(Done 12/05/17)*
    * [x] Learn how to describe API info *(Done 12/04/17)*
    * [x] Learn how to describe data models *(Done 12/04/17)*
    * [x] Learn how to describe request body *(Done 12/04/17)*
    * [x] Learn how to specify that ID is required for responses only *(Done 12/04/17)*
  * Describe all necessary endpoints using OpenAPI spec
    * Describe data models
      * [x] Transaction *(Done 12/04/17)*
      * [x] Account *(Done 12/05/17)*
      * [x] Counterparty *(Done 12/05/17)*
      * [x] Currency *(Done 12/05/17)*
      * [ ] Balance
    * Transactions
      * [x] POST *(Done 12/05/17)*
      * [x] GET *(Done 12/05/17)*
    * Transactions/id
      * [x] GET *(Done 12/05/17)*
      * [x] PUT *(Done 12/05/17)*
      * [x] DELETE *(Done 12/05/17)*
    * Accounts *(Done 12/05/17)*
      * [x] POST *(Done 12/05/17)*
      * [x] GET *(Done 12/05/17)*
    * Accounts/id
      * [x] GET *(Done 12/05/17)*
      * [x] PUT *(Done 12/05/17)*
      * [x] DELETE *(Done 12/05/17)*
    * Counterparties *(Done 12/05/17)*
      * [x] POST *(Done 12/05/17)*
      * [x] GET *(Done 12/05/17)*
    * Counterparties/id
      * [x] GET *(Done 12/05/17)*
      * [x] PUT *(Done 12/05/17)*
      * [x] DELETE *(Done 12/05/17)*
    * Currencies
      * [ ] *addCurrency*
      * [x] GET *(Done 12/05/17)*
    * Currencies/id
      * [x] GET *(Done 12/05/17)*
      * [ ] *updateCurrencyById*
      * [ ] *deleteCurrencyById*
* [x] Implement SQLite schema creation scripts *(Done 12/06/17)*
  * [x] Add several basic currencies manually *(Done 12/17/17)*
* [x] Install Swagger Codegen and generate Flask API
  (3.0.0 is not implemented yet in Codegen)
* [ ] Implement REST API using Python and Flask
  * Implement ORM via SQLAlchemy
    * [x] Implement Source model *(Done 12/08/17)*
    * [x] Implement Currency model *(Done 12/07/17)*
    * [x] Implement Counterparty model *(Done 12/07/17)*
    * [x] Implement Account model *(Done 12/08/17)*
    * [x] Implement Transaction model *(Done 12/11/17)*
  * Implement endpoints
    * currencies
      * [x] get_currency_by_id *(Done 12/17/17)*
      * [x] get_currencies *(Done 12/17/17)*
    * counterparties
      * [ ] get_counterparty_by_id
      * [ ] get_counterparties
      * [ ] create_counterparty
      * [ ] update_counterparty_by_id
      * [ ] delete_counterparty_by_id
    * accounts
      * [ ] get_account_by_id
      * [ ] get_accounts
      * [ ] create_account
      * [ ] update_account_by_id
      * [ ] delete_account_by_id
    * transactions
      * [ ] get_transaction_by_id
      * [ ] get_transactions
      * [ ] create_transaction
      * [ ] update_transaction_by_id
      * [ ] delete_transaction_by_id
* [ ] Integrate REST API into existing Desktop Qt Client
* [ ] Implement data importer for ING
  * [ ] Design data flow
  * [ ] Design algorithm
    * [ ] Find a way around transactions that are imported twice
    * [ ] Some imported transactions might not be accounted yet.
      Need to find a way to update them when new import is done.
    * [ ] Transactions with early hold and late accounted dates are listed
      two times.
* [ ] Implement data importer for Tinkoff
* [ ] Implement data uploader from older records in Google Sheets
* [ ] Implement PostgreSQL schema
* [ ] Implement API using Amazon's Lambda functions and Gateways
* [ ] Implement Mobile App using Flutter
* [ ] Incorporate ElasticSearch for faster search through transaction
  details and descriptions
