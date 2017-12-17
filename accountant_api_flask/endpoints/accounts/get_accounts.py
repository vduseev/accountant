from app import app
from database_orm.models.account import Account
from endpoints.accounts import basic_response
from endpoints.jsonify import jsonify


@app.route('/accounts', methods=['GET'])
def get_accounts():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for all accounts
    accounts = Account.query.all()

    # Put count of accounts to response object
    response['count'] = len(accounts)
    for account in accounts:
        response['accounts'].append(account.to_dict())

    return jsonify(response)
