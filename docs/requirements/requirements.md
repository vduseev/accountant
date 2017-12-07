# Requirements
* Desktop application with rich functionality.
* Mobile application to quickly log expenses.
* Both apps should be in sync.

## General specs
* A transaction is not associated with particular currency.
  * Transaction has NOMINAL amount, HOLD amount, ant WITHDRAW amount,
    all with their own currencies.
* Currency list is predefined. User cannot change it.

### User specs
* User may have many financial accounts.

### Account specs
* Account must have unique name in this user's domain.
* Account may have description.
* Account must have currency associated with it.
* Total sum of all transactions for one account equals zero.

### Transaction specs
* Transaction always happens between two specific accounts.
  * Money is withdrawn from FROM_ACCOUNT.
  * Money is transferred to TO_ACCOUNT.
* Transaction must have NOMINAL amount and currency.
* Transaction must have WITHDRAW amount and currency.
* WITHDRAW currency must me equal to FROM_ACCOUNT currency.
* Transaction may have HOLD amount and currency.
* ``TBD Transaction has history of statuses``
* ``TBD Transaction can block the money on account, but not withdraw it``
* ``TBD Transaction can be canceled``
  * ``Blocked money will be unblocked``
  * ``User can see how transaction was created with HOLD amount
    then was canceled with same HOLD amount, but WITHDRAW zero.``

## Desktop Application

### Functional Requirements
* All declared functionality is available
* Bank records import
* Reports

### Non-functional Requirements
* Excel-like style of editing
* Same work principles on each platform

## Mobile Application

## Cloud
* User profile
* I want to log in and out, switch user profiles
