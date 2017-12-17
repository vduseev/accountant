from flask import Flask
from database_orm import Database


app = Flask(__name__)

@app.teardown_appcontext
def shutdown_session(exception=None):
    Database.shutdown_session()


@app.route('/')
def hello_world():
    return 'Hello World!'
