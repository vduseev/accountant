from flask import Flask
from models.database import db_session
from models.database import init_db

init_db()
app = Flask(__name__)


@app.teardown_appcontext
def shutdown_session(exception=None):
    db_session.remove()


@app.route('/')
def hello_world():
    return 'Hello World!'
