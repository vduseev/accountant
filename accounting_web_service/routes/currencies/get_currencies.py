from app import app
from flask import request
from model.currency import Currency
from model.database import db_session
from sqlalchemy.exc import IntegrityError
from routes import status_codes
from routes.currencies import basic_response
from routes.jsonify import jsonify


@app.route('/currencies', methods=['GET'])
def get_currencies():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for all currencies
    currencies = Currency.query.all()

    # Put count of currencies to response object
    response['count'] = len(currencies)
    for currency in currencies:
        response['currencies'].append(currency.to_dict())

    return jsonify(response)
