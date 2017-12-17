from app import app
from database_orm.models.counterparty import Counterparty
from endpoints.entities import basic_response
from endpoints.jsonify import jsonify


@app.route('/entities', methods=['GET'])
def get_entities():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for all entities
    entities = Counterparty.query.all()

    # Put count of entities to response object
    response['count'] = len(entities)
    for entity in entities:
        response['entities'].append(entity.to_dict())

    return jsonify(response)
