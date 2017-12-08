from app import app
from flask import request
from database_orm.counterparty import Counterparty
from database_orm.database import db_session
from sqlalchemy.exc import ArgumentError
from endpoints import status_codes
from endpoints.jsonify import jsonify
from endpoints.entities import basic_response


@app.route('/entities/<uuid:entity_id>', methods=['GET'])
def get_entity(entity_id):
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for entity by id
    entity = Counterparty.query.filter_by(id = entity_id).first()

    if entity is None:
        response['status']['code'] = status_codes.NOT_FOUND
    else:
        response['count'] = 1
        response['entities'].append(entity.to_dict())

    return jsonify(response)
