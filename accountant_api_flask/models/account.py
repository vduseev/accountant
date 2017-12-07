from uuid import uuid4

from sqlalchemy import Table, Column, String, ForeignKey
from sqlalchemy.dialects.postgresql import UUID, TEXT, REAL
from sqlalchemy.orm import mapper

from models.database import metadata, db_session
from models.initialization_exc import ModelInitializationError


class Account:
    query = db_session.query_property()

    def __init__(self, name, desc, entity_id, currency_id, balance):
        self.id = uuid4()
        self.name = name
        self.desc = desc
        self.entity_id = entity_id
        self.currency_id = currency_id
        self.balance = balance

    def __init__(self, account_as_dict):
        errors = Account.validate_initialization_dict(account_as_dict)
        if len(errors) > 0:
            raise ModelInitializationError(errors)
        else:
            self.id = uuid4()
            self.name = account_as_dict['name']
            self.desc = account_as_dict['desc']
            self.entity_id = account_as_dict['entity_id']
            self.currency_id = account_as_dict['currency_id']
            self.balance = account_as_dict['balance']

    def to_dict(self):
        return {
            'id': str(self.id),
            'name': self.name,
            'desc': self.desc,
            'entity_id': self.entity_id,
            'currency_id': self.currency_id,
            'balance': self.balance
        }

    @staticmethod
    def validate_initialization_dict(account_as_dict):
        errors = []
        if 'name' not in account_as_dict:
            errors.append('"name" field not found')
        if 'desc' not in account_as_dict:
            errors.append('"desc" field not found')
        if 'entity_id' not in account_as_dict:
            errors.append('"entity_id" field not found')
        if 'currency_id' not in account_as_dict:
            errors.append('"currency_id" field not found')
        if 'balance' not in account_as_dict:
            errors.append('"balance" field not found')
        if len(account_as_dict.keys()) > 5:
            errors.append('Unwanted keys found')
        return errors

accounts = Table(
    'accounts',
    metadata,
    Column('id', UUID, primary_key=True),
    Column('name', String(255), nullable=False),
    Column('desc', TEXT, nullable=False),
    Column('entity_id', UUID, ForeignKey('accounting.entities.id'), nullable=False),
    Column('currency_id', UUID, ForeignKey('accounting.currencies.id'), nullable=False),
    Column('balance', REAL, nullable=False),
    schema='accounting'
)

mapper(Account, accounts)
