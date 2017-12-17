from flask import jsonify as flask_jsonify


def jsonify(response, status_code):
    jsonified_response = flask_jsonify(response)
    jsonified_response.status_code = status_code
    return jsonified_response
