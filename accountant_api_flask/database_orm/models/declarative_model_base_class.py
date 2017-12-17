from database_orm import Database
from sqlalchemy.ext.declarative import declarative_base


# This is similar to declaration of a normal class as declarative_base
# return a class, not an object.
DeclarativeModelBaseClass = declarative_base()
DeclarativeModelBaseClass.query = Database.Session.query_property()
