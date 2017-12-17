from sqlalchemy import Column, BIGINT, TEXT, INTEGER
from database_orm.models import DeclarativeModelBaseClass


class Currency(DeclarativeModelBaseClass):

    # Required for ORM functionality.
    __tablename__ = 'currencies'
    id = Column(BIGINT, primary_key=True)
    name = Column(TEXT, nullable=False)
    code = Column(TEXT, nullable=False)
    num = Column(TEXT, nullable=True)
    digits_after_decimal = Column(INTEGER, nullable=False)
    warehoused_at = Column(TEXT, nullable=False)
    updated_at = Column(TEXT, nullable=False)

    def to_dict(self):
        return dict(
            id=str(self.id),
            name=self.name,
            code=self.code,
            num=self.num,
            digits_after_decimal=self.digits_after_decimal,
            warehoused_at=self.warehoused_at,
            updated_at=self.updated_at
        )

    def to_ref_dict(self):
        return dict(
            id=str(self.id),
            name=self.name,
            code=self.code,
            num=self.num,
            digits_after_decimal=self.digits_after_decimal
        )
