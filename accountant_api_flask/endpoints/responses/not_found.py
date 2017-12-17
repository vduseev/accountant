from .error_response_base import error
from endpoints.jsonify import jsonify


def not_found(message):
    return jsonify(error(404, message), 404)
