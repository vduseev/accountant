from routes import status_codes


def get_basic_response():
    """ Response consists of 3 fields: 'int:count' and 'list:accounts' and 'dict:status' """
    return {
        'count': 0,
        'accounts': [],
        'status': {
            'code': status_codes.OK,
            'errors': []
        }
    }
