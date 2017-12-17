from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker


class Database:
    Engine = create_engine(
        #'postgresql://accountant:DatCast11@localhost:5432/accounting',
        'sqlite:////Users/vduseev/Development/accountant/accountant_db_sqlite/accountant.db',
        convert_unicode=True
    )

    Session = scoped_session(
        sessionmaker(
            autocommit=False,
            autoflush=False,
            bind=Engine
        )
    )

    @staticmethod
    def shutdown_session():
        Database.Session.remove()
