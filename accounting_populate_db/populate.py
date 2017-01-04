import requests

API_URL = 'http://localhost:5000'


def post_currency(currency):
    url = API_URL + '/currencies'
    response = requests.post(url, json=currency)
    if response.status_code == 201:
        print(currency['iso4217_code'], 'posted successfully.', 'Status:', response.json()['status'])
    else:
        print(currency['iso4217_code'], 'not posted.', 'Status:', response.json()['status'])


def populate_currencies():
    from data import currencies
    for currency in currencies.CURRENCIES:
        post_currency(currency)


def populate():
    populate_currencies()


populate()
