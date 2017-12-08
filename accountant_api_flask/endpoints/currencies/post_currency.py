from app import app
from flask import request
from database_orm.currency import Currency
from database_orm.initialization_exc import ModelInitializationError
from database_orm.database import db_session
from sqlalchemy.exc import IntegrityError, ProgrammingError
from endpoints.currencies import basic_response
from endpoints import status_codes
from endpoints.jsonify import jsonify


@app.route('/currencies', methods=['POST'])
def post_currency():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Get request JSON
    currency_data_from_request = request.get_json()
    # Check if it's valid JSON
    if currency_data_from_request is None:
        response['status']['code'] = status_codes.BAD_REQUEST
        response['status']['errors'].append('Incoming data is not application/json')
    else:
        try:
            # Initialize currency (exception will be thrown is JSON is not valid)
            currency = Currency(currency_data_from_request)
            # Add to database (exception will be thrwn from database if smth is wrong)
            db_session.add(currency)
            db_session.commit()
            # Respond to user with new ID
            response['count'] = 1
            response['currencies'].append(currency.to_dict())
            response['status']['code'] = status_codes.CREATED
        except ModelInitializationError as initError:
            response['status']['code'] = status_codes.BAD_REQUEST
            response['status']['errors'] = initError.errors
        except IntegrityError as integrityError:
            response['status']['code'] = status_codes.INTERNAL_SERVER_ERROR
            response['status']['errors'].append(str(integrityError.orig))
        except ProgrammingError as programmingError:
            response['status']['code'] = status_codes.INTERNAL_SERVER_ERROR
            response['status']['errors'].append(str(programmingError.orig))

    return jsonify(response)
