from routes import status_codes


def get_basic_response():
    """ Response consists of 2 fields: 'int:count' and 'list:entities' and 'dict:status' """
    return {
        'count': 0,
        'entities': [],
        'status': {
            'code': status_codes.OK,
            'errors': []
        }
    }
