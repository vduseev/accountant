from uuid import uuid4

from sqlalchemy import Table, Column, String
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import mapper

from model.database import metadata, db_session
from model.initialization_exc import ModelInitializationError

import json


class Currency(object):
    query = db_session.query_property()

    def __init__(self, name, desc, iso4217_code, iso4217_num):
        self.id = uuid4()
        self.name = name
        self.desc = desc
        self.iso4217_code = iso4217_code
        self.iso4217_num = iso4217_num

    def __init__(self, currency_as_dict):
        errors = Currency.validate_initialization_dict(currency_as_dict)
        if len(errors) > 0:
            raise ModelInitializationError(errors)
        else:
            self.id = uuid4()
            self.name = currency_as_dict['name']
            self.desc = currency_as_dict['desc']
            self.iso4217_code = currency_as_dict['iso4217_code']
            self.iso4217_num = currency_as_dict['iso4217_num']

    def to_dict(self):
        return {
            'id': str(self.id),
            'name': self.name,
            'desc': self.desc,
            'iso4217_code': self.iso4217_code,
            'iso4217_num': self.iso4217_num
        }

    @staticmethod
    def validate_initialization_dict(currency_as_dict):
        errors = []
        if 'name' not in currency_as_dict:
            errors.append('"name" field not found')
        if 'desc' not in currency_as_dict:
            errors.append('"desc" field not found')
        if 'iso4217_code' not in currency_as_dict:
            errors.append('"iso4217_code" field not found')
        if 'iso4217_num' not in currency_as_dict:
            errors.append('"iso4217_num" field not found')
        if len(currency_as_dict.keys()) > 4:
            errors.append('Unwanted keys found')
        return errors

currencies = Table(
    'currencies',
    metadata,
    Column('id', UUID(as_uuid=True), primary_key=True),
    Column('name', String(255), nullable=False, unique=True),
    Column('desc', String(255), nullable=False),
    Column('iso4217_code', String(3), nullable=False, unique=True),
    Column('iso4217_num', String(3), nullable=False, unique=True),
    schema='accounting'
)

mapper(Currency, currencies)
