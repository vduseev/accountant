from uuid import uuid4

from sqlalchemy import Table, Column, ForeignKey
from sqlalchemy.dialects.postgresql import UUID, TEXT, REAL, TIMESTAMP
from sqlalchemy.orm import mapper

from model.database import metadata, db_session
from model.initialization_exc import ModelInitializationError


class Transaction:
    query = db_session.query_property()

    def __init__(self, id, from_id, to_id, currency_id, amount, desc, timestamp):
        self.id = uuid4()
        self.from_id = from_id
        self.to_id = to_id
        self.currency_id = currency_id
        self.amount = amount
        self.desc = desc
        self.timestamp = timestamp

    def __init__(self, transaction_as_dict):
        errors = Transaction.validate_initialization_dict(transaction_as_dict)
        if len(errors) > 0:
            raise ModelInitializationError(errors)
        else:
            self.id = uuid4()
            self.from_id = transaction_as_dict['from_id']
            self.to_id = transaction_as_dict['to_id']
            self.currency_id = transaction_as_dict['currency_id']
            self.amount = transaction_as_dict['amount']
            self.desc = transaction_as_dict['desc'] if 'desc' in transaction_as_dict else ''
            self.timestamp = transaction_as_dict['timestamp'] if 'timestamp' in transaction_as_dict else None

    def to_dict(self):
        return {
            'id': str(self.id),
            'from_id': self.from_id,
            'to_id': self.to_id,
            'currency_id': self.currency_id,
            'amount': self.amount,
            'desc': self.desc,
            'timestamp': self.timestamp
        }

    @staticmethod
    def validate_initialization_dict(transaction_as_dict):
        errors = []
        if 'from_id' not in transaction_as_dict:
            errors.append('"from_id" field not found')
        if 'to_id' not in transaction_as_dict:
            errors.append('"to_id" field not found')
        if 'currency_id' not in transaction_as_dict:
            errors.append('"currency_id" field not found')
        if 'amount' not in transaction_as_dict:
            errors.append('"amount" field not found')
        if len(transaction_as_dict.keys()) > 5:
            errors.append('Unwanted keys found')
        return errors

transactions = Table(
    'transactions',
    metadata,
    Column('id', UUID, primary_key=True),
    Column('from_id', UUID, ForeignKey('accounting.accounts.id'), nullable=False),
    Column('to_id', UUID, ForeignKey('accounting.accounts.id'), nullable=False),
    Column('currency_id', UUID, ForeignKey('accounting.currencies.id'), nullable=False),
    Column('amount', REAL, nullable=False),
    Column('desc', TEXT),
    Column('timestamp', TIMESTAMP, nullable=False, default=TIMESTAMP(timezone=True)),
    schema='accounting'
)

mapper(Transaction, transactions)
