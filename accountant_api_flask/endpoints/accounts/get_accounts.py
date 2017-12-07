from app import app
from flask import request
from models.account import Account
from models.database import db_session
from sqlalchemy.exc import IntegrityError
from endpoints import status_codes
from endpoints.accounts import basic_response
from endpoints.jsonify import jsonify


@app.route('/accounts', methods=['GET'])
def get_accounts():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for all accounts
    accounts = Account.query.all()

    # Put count of accounts to response object
    response['count'] = len(accounts)
    for account in accounts:
        response['accounts'].append(account.to_dict())

    return jsonify(response)
