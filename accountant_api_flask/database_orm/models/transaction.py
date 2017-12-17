from sqlalchemy import Column, ForeignKey, BIGINT, TEXT, REAL
from sqlalchemy.orm import relationship

from database_orm.exceptions.model_initialization_exception import ModelInitializationException


class Transaction:

    # Required for ORM functionality.
    __tablename__ = 'transactions'
    id = Column(
        BIGINT, primary_key=True)
    title = Column(
        TEXT, nullable=False)
    details = Column(
        TEXT, nullable=True)
    withdrawn_account_id = Column(
        BIGINT, ForeignKey('accounts.id'), nullable=False)
    deposited_account_id = Column(
        BIGINT, ForeignKey('accounts.id'), nullable=False)
    payment_amount = Column(
        REAL, nullable=False)
    hold_amount = Column(
        REAL, nullable=False)
    transaction_amount = Column(
        REAL, nullable=True)
    payment_currency_id = Column(
        BIGINT, ForeignKey('currencies.id'), nullable=False)
    transactioned_at = Column(
        TEXT, nullable=False)
    accounted_at = Column(
        TEXT, nullable=True)
    warehoused_at = Column(
        TEXT, nullable=False)
    updated_at = Column(
        TEXT, nullable=False)
    source_id = Column(
        BIGINT, ForeignKey('sources.id'), nullable=False)

    # Relationships based on FK
    withdrawn_account = relationship(
        'Account', foreign_keys=[withdrawn_account_id])
    deposited_account = relationship(
        'Account', foreign_keys=[deposited_account_id])
    payment_currency = relationship(
        'Currency', foreign_keys=[payment_currency_id])
    source = relationship(
        'Source', foreign_keys=[source_id])

    def __init__(self, transaction):
        self.validate(transaction)
        self.title = transaction['title']
        self.details = transaction['details']
        self.withdrawn_account_id = transaction['withdrawn_account']['id']
        self.deposited_account_id = transaction['deposited_account']['id']
        self.payment_amount = transaction['payment_amount']
        self.hold_amount = transaction['hold_amount']
        self.transaction_amount = transaction['transaction_amount']
        self.payment_currency_id = transaction['payment_currency']['id']
        self.transactioned_at = transaction['transactioned_at']
        self.accounted_at = transaction['accounted_at']
        self.source_id = transaction['source']['id']

    def to_dict(self):
        return dict(
            id=str(self.id),
            title=self.title,
            details=self.details,
            withdrawn_account=self.withdrawn_account.to_ref_dict(),
            deposited_account=self.deposited_account.to_ref_dict(),
            payment_amount=self.payment_amount,
            hold_amount=self.hold_amount,
            transaction_amount=self.transaction_amount,
            payment_currency=self.payment_currency.to_ref_dict(),
            transactioned_at=self.transactioned_at,
            accounted_at=self.accounted_at,
            warehoused_at=self.warehoused_at,
            updated_at=self.updated_at,
            source=self.source.to_ref_dict()
        )

    @staticmethod
    def validate(transaction):
        errors = []
        if 'title' not in transaction:
            errors.append('"title" field not found')
        if 'details' not in transaction:
            errors.append('"details" field not found')
        if 'withdrawn_account' not in transaction:
            errors.append('"withdrawn_account" not found')
        elif 'id' not in transaction['withdrawn_account']:
            errors.append('"withdrawn_account.id" not found')
        if 'deposited_account' not in transaction:
            errors.append('"deposited_account" not found')
        elif 'id' not in transaction['deposited_account']:
            errors.append('"deposited_account.id" field not found')
        if 'payment_amount' not in transaction:
            errors.append('"payment_amount" field not found')
        if 'hold_amount' not in transaction:
            errors.append('"hold_amount" field not found')
        if 'payment_currency' not in transaction:
            errors.append('"payment_currency" not found')
        elif 'id' not in transaction['payment_currency']:
            errors.append('"payment_currency.id" field not found')
        if 'transactioned_at' not in transaction:
            errors.append('"transactioned_at" field not found')
        if 'accounted_at' not in transaction:
            errors.append('"accounted_at" field not found')
        if 'source' not in transaction:
            errors.append('"source" not found')
        elif 'id' not in transaction['source']:
            errors.append('"source.id" field not found')
        if len(errors) > 0:
            raise ModelInitializationException(errors)
