from .error_response_base import error
from endpoints.jsonify import jsonify


def bad_request(message):
    return jsonify(error(400, message), 400)
