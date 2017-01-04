from app import app
from flask import request
from model.account import Account
from model.database import db_session
from sqlalchemy.exc import ArgumentError
from routes import status_codes
from routes.jsonify import jsonify
from routes.accounts import basic_response


@app.route('/accounts/<uuid:account_id>', methods=['GET'])
def get_account(account_id):
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for account by id
    account = Account.query.filter_by(id = account_id).first()

    if account is None:
        response['status']['code'] = status_codes.NOT_FOUND
    else:
        response['count'] = 1
        response['accounts'].append(account.to_dict())

    return jsonify(response)
