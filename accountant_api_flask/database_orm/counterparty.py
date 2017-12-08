from sqlalchemy import Column, ForeignKey, BIGINT, TEXT
from sqlalchemy.orm import relationship
from database_orm import DeclarativeModelBaseClass
from database_orm.initialization_exc import ModelInitializationError


class Counterparty(DeclarativeModelBaseClass):

    # Mapping required for ORM functionality.
    __tablename__ = 'counterparties'
    id = Column(BIGINT, primary_key=True)
    name = Column(TEXT, nullable=False)
    details = Column(TEXT, nullable=True)
    warehoused_at = Column(TEXT, nullable=False)
    updated_at = Column(TEXT, nullable=False)
    source_id = Column(BIGINT, ForeignKey('sources.id'), nullable=False)

    source = relationship('Source', foreign_keys=[source_id])

    def __init__(self, counterparty):
        self.validate(counterparty)
        self.name = counterparty['name']
        self.details = counterparty['details']
        self.source_id = counterparty['source']['id']

    def to_dict(self):
        return dict(
            id=str(self.id),
            name=self.name,
            details=self.details,
            warehoused_at=self.warehoused_at,
            updated_at=self.updated_at,
            source_id=self.source_id
        )

    @staticmethod
    def validate(counterparty):
        errors = []
        if 'name' not in counterparty:
            errors.append('"name" field not found')
        if 'source' not in counterparty:
            if 'id' not in counterparty['source']:
                errors.append('"source.id" field not found')
        if len(errors) > 0:
            raise ModelInitializationError(errors)
