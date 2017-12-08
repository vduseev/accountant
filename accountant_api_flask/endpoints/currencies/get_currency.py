from app import app
from flask import request
from database_orm.currency import Currency
from database_orm.database import db_session
from sqlalchemy.exc import ArgumentError
from endpoints import status_codes
from endpoints.jsonify import jsonify
from endpoints.currencies import basic_response


@app.route('/currencies/<uuid:currency_id>', methods=['GET'])
def get_currency(currency_id):
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for currency by id
    currency = Currency.query.filter_by(id = currency_id).first()

    if currency is None:
        response['status']['code'] = status_codes.NOT_FOUND
    else:
        response['count'] = 1
        response['currencies'].append(currency.to_dict())

    return jsonify(response)
