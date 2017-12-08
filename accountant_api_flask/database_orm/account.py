from uuid import uuid4

from sqlalchemy import Column, ForeignKey, BIGINT, TEXT
from sqlalchemy.orm import relationship

from database_orm import DeclarativeModelBaseClass
from database_orm.initialization_exc import ModelInitializationError


class Account(DeclarativeModelBaseClass):

    __tablename__ = 'accounts'
    id = Column(BIGINT, primary_key=True)
    name = Column(TEXT, nullable=False)
    details = Column(TEXT, nullable=True)
    currency_id = Column(
        BIGINT, ForeignKey('currencies.id'), nullable=False
    )
    counterparty_id = Column(
        BIGINT, ForeignKey('counterparties.id'), nullable=False
    )
    warehoused_at = Column(TEXT, nullable=False)
    updated_at = Column(TEXT, nullable=False)
    source_id = Column(BIGINT, ForeignKey('sources.id'), nullable=False)

    currency = relationship('Currency', foreign_keys=[currency_id])
    counterparty = relationship('Counterparty', foreign_keys=[counterparty_id])
    source = relationship('Source', foreign_keys=[source_id])

    def __init__(self, account):
        self.validate(account)
        self.name = account['name']
        self.details = account['details']
        self.currency_id = account['currency']['id']
        self.counterparty_id = account['counterparty']['id']
        self.source_id = account['source']['id']

    def to_dict(self):
        return dict(
            id=str(self.id),
            name=self.name,
            details=self.details,
            currency=self.currency.to_reference_dict(),
            counterparty=self.counterparty.to_reference_dict(),
            warehoused_at=self.warehoused_at,
            updated_at=self.updated_at,
            source=self.source.to_reference_dict()
        )

    @staticmethod
    def validate(account):
        errors = []
        if 'name' not in account:
            errors.append('"name" field not found')
        if 'details' not in account:
            errors.append('"details" field not found')
        if 'currency' not in account:
            if 'id' not in account['currency']:
                errors.append('"currency.id" field not found')
        if 'counterparty' not in account:
            if 'id' not in account['counterparty']:
                errors.append('"counterparty.id" field not found')
        if 'source' not in account:
            if 'id' not in account['source']:
                errors.append('"source.id" field not found')
        if len(errors) > 0:
            raise ModelInitializationError(errors)
