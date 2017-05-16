from app import app
from flask import request
from model.transaction import Transaction
from model.initialization_exc import ModelInitializationError
from model.database import db_session
from sqlalchemy.exc import IntegrityError
from sqlalchemy.exc import ProgrammingError
from routes.transactions import basic_response
from routes import status_codes
from routes.jsonify import jsonify


@app.route('/transactions', methods=['POST'])
def post_transaction():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Get request JSON
    transaction_data_from_request = request.get_json()
    # Check if it's valid JSON
    if transaction_data_from_request is None:
        response['status']['code'] = status_codes.BAD_REQUEST
        response['status']['errors'].append('Incoming data is not application/json')
    else:
        try:
            # Initialize transaction (exception will be thrown is JSON is not valid)
            transaction = Transaction(transaction_data_from_request)
            # Add to database (exception will be thrown from database if smth is wrong)
            db_session.add(transaction)
            db_session.commit()
            # Respond to user with new ID
            response['count'] = 1
            response['transactions'].append(transaction.to_dict())
            response['status']['code'] = status_codes.CREATED
        except ModelInitializationError as initError:
            response['status']['code'] = status_codes.BAD_REQUEST
            response['status']['errors'] = initError.errors
        except IntegrityError as integrityError:
            response['status']['code'] = status_codes.INTERNAL_SERVER_ERROR
            response['status']['errors'] = integrityError.detail
        except ProgrammingError as programmingError:
            response['status']['code'] = status_codes.INTERNAL_SERVER_ERROR
            response['status']['errors'].append(str(programmingError.orig))

    return jsonify(response)