from app import app
from flask import request
from model.transaction import Transaction
from model.database import db_session
from sqlalchemy.exc import IntegrityError
from routes import status_codes
from routes.transactions import basic_response
from routes.jsonify import jsonify


@app.route('/transactions', methods=['GET'])
def get_transactions():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for all transactions
    transactions = Transaction.query.all()

    # Put count of transactions to response object
    response['count'] = len(transactions)
    for transaction in transactions:
        response['transactions'].append(transaction.to_dict())

    return jsonify(response)
