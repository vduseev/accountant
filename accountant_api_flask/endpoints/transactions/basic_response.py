from endpoints import status_codes


def get_basic_response():
    """ Response consists of 2 fields: 'int:count' and 'list:transactions' and 'dict:status' """
    return {
        'count': 0,
        'transactions': [],
        'status': {
            'code': status_codes.OK,
            'errors': []
        }
    }
