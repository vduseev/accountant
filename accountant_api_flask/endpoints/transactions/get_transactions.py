from app import app
from flask import request
from database_orm.transaction import Transaction
from database_orm.database import db_session
from sqlalchemy.exc import IntegrityError
from endpoints import status_codes
from endpoints.transactions import basic_response
from endpoints.jsonify import jsonify


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
