from app import app
from database_orm import Currency
from endpoints.jsonify import jsonify
from endpoints.responses import success, not_found


@app.route('/currencies', methods=['GET'])
def get_currencies():
    # Query database for all currencies
    currencies = Currency.query.all()

    # Form a dict response
    response = [currency.to_dict() for currency in currencies]

    # Send BadRequest if query parameters are messed up.
    # e.g. from is < 0 and size is < 1

    if len(response) == 0:
        return not_found('No currencies were found')

    # Return JSONified response to client
    return success(response)
