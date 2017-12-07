from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import scoped_session, sessionmaker

engine = create_engine('postgresql://accountant:DatCast11@localhost:5432/accounting', convert_unicode=True)
metadata = MetaData()
db_session = scoped_session(sessionmaker(autocommit=False,
                                         autoflush=False,
                                         bind=engine))


def init_db():
    print('db initialized')
    # import all modules here that might define models so that
    # they will be registered properly on the metadata.  Otherwise
    # you will have to import them first before calling init_db()
    import models.currency
    import models.entity
    import models.account
    import models.transaction
    # Base.metadata.create_all(bind=engine)
