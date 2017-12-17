from sqlalchemy import Column, BIGINT, TEXT
from database_orm.models import DeclarativeModelBaseClass


class Source(DeclarativeModelBaseClass):

    # Required for ORM functionality.
    __tablename__ = 'sources'
    id = Column(BIGINT, primary_key=True),
    name = Column(TEXT, nullable=False),
    details = Column(TEXT, nullable=True),

    def to_dict(self):
        return dict(
            id=str(self.id),
            name=self.name,
            details=self.details
        )

    def to_ref_dict(self):
        return dict(
            id=str(self.id),
            name=self.name
        )
