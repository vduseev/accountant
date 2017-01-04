from flask import jsonify as flask_jsonify


def jsonify(response):
    jsonified_response = flask_jsonify(response)
    jsonified_response.status_code = response['status']['code']
    return jsonified_response
