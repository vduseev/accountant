from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine(
    'postgresql://accountant:DatCast11@localhost:5432/accounting',
    convert_unicode=True
)

# metadata = MetaData()

db_session = scoped_session(
    sessionmaker(
        autocommit=False,
        autoflush=False,
        bind=engine
    )
)

DeclarativeModelBaseClass = declarative_base()
DeclarativeModelBaseClass.query = db_session.query_property()


def init_db():
    print('db initialized')
    # import all modules here that might define database_orm so that
    # they will be registered properly on the metadata.  Otherwise
    # you will have to import them first before calling init_db()
    import database_orm.currency
    import database_orm.counterparty
    import database_orm.account
    import database_orm.transaction
    # Base.metadata.create_all(bind=engine)
