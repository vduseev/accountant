from endpoints.jsonify import jsonify


def created(response_body):
    return jsonify(response_body, 204)
