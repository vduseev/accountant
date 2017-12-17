from app import app
from database_orm import Currency
from endpoints.responses import not_found, success, bad_request


@app.route('/currencies/<int:currency_id>', methods=['GET'])
def get_currency(currency_id):
    if type(currency_id) != int:
        return bad_request('currency_id query parameter must be a number')

    # Query database for currency by id
    currency = Currency.query.filter_by(id=currency_id).first()

    # If currency was not found
    if currency is None:
        return not_found('Currency was not found')

    return success(currency.to_dict())
