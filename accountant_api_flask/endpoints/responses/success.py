from endpoints.jsonify import jsonify


def success(response_body):
    return jsonify(response_body, 200)
