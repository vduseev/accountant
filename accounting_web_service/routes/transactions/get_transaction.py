from app import app
from flask import request
from model.transaction import Transaction
from model.database import db_session
from sqlalchemy.exc import ArgumentError
from routes import status_codes
from routes.jsonify import jsonify
from routes.transactions import basic_response


@app.route('/transactions/<uuid:transaction_id>', methods=['GET'])
def get_transaction(transaction_id):
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for transaction by id
    transaction = Transaction.query.filter_by(id = transaction_id).first()

    if transaction is None:
        response['status']['code'] = status_codes.NOT_FOUND
    else:
        response['count'] = 1
        response['transactions'].append(transaction.to_dict())

    return jsonify(response)
