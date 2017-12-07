from uuid import uuid4

from sqlalchemy import Table, Column, String
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import mapper

from models.database import metadata, db_session
from models.initialization_exc import ModelInitializationError


class Entity(object):
    query = db_session.query_property()

    def __init__(self, name, country, city, address, legal_name, legal_address):
        self.id = uuid4()
        self.name = name
        self.country = country
        self.city = city
        self.address = address
        self.legal_name = legal_name
        self.legal_address = legal_address

    def __init__(self, currency_as_dict):
        errors = Entity.validate_initialization_dict(currency_as_dict)
        if len(errors) > 0:
            raise ModelInitializationError(errors)
        else:
            self.id = uuid4()
            self.name = currency_as_dict['name']
            self.country = currency_as_dict['country']
            self.city = currency_as_dict['city']
            self.address = currency_as_dict['address']
            self.legal_name = currency_as_dict['legal_name']
            self.legal_address = currency_as_dict['legal_address']

    def to_dict(self):
        return {
            'id': str(self.id),
            'name': self.name,
            'country': self.country,
            'city': self.city,
            'address': self.address,
            'legal_name': self.legal_name,
            'legal_address': self.legal_address
        }

    @staticmethod
    def validate_initialization_dict(entity_as_dict):
        errors = []
        if 'name' not in entity_as_dict:
            errors.append('"name" field not found')
        if 'country' not in entity_as_dict:
            errors.append('"country" field not found')
        if 'city' not in entity_as_dict:
            errors.append('"city" field not found')
        if 'address' not in entity_as_dict:
            errors.append('"address" field not found')
        if 'legal_name' not in entity_as_dict:
            pass
        if 'legal_address' not in entity_as_dict:
            pass
        if len(entity_as_dict.keys()) > 4:
            errors.append('Unwanted keys found')
        return errors

entities = Table(
    'entities',
    metadata,
    Column('id', UUID, primary_key=True),
    Column('name', String(255), nullable=False),
    Column('country', String(255), nullable=False),
    Column('city', String(255), nullable=False),
    Column('address', String(255), nullable=False),
    Column('legal_name', String(255), nullable=False),
    Column('legal_address', String(255), nullable=False),
    schema='accounting'
)

mapper(Entity, entities)
