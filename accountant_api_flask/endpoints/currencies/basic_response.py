from endpoints import status_codes


def get_basic_response():
    """ Response consists of 2 fields: 'int:count' and 'list:currencies' """
    return {
        'count': 0,
        'currencies': [],
        'status': {
            'code': status_codes.OK,
            'errors': []
        }
    }
