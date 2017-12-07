from app import app
from flask import request
from models.entity import Entity
from models.database import db_session
from sqlalchemy.exc import IntegrityError
from endpoints import status_codes
from endpoints.entities import basic_response
from endpoints.jsonify import jsonify


@app.route('/entities', methods=['GET'])
def get_entities():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Query database for all entities
    entities = Entity.query.all()

    # Put count of entities to response object
    response['count'] = len(entities)
    for entity in entities:
        response['entities'].append(entity.to_dict())

    return jsonify(response)