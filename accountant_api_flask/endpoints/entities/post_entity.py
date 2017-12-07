from app import app
from flask import request
from models.entity import Entity
from models.initialization_exc import ModelInitializationError
from models.database import db_session
from sqlalchemy.exc import IntegrityError
from sqlalchemy.exc import ProgrammingError
from endpoints.entities import basic_response
from endpoints import status_codes
from endpoints.jsonify import jsonify


@app.route('/entities', methods=['POST'])
def post_entity():
    # Prepare basic response
    response = basic_response.get_basic_response()

    # Get request JSON
    entity_data_from_request = request.get_json()
    # Check if it's valid JSON
    if entity_data_from_request is None:
        response['status']['code'] = status_codes.BAD_REQUEST
        response['status']['errors'].append('Incoming data is not application/json')
    else:
        try:
            # Initialize entity (exception will be thrown is JSON is not valid)
            entity = Entity(entity_data_from_request)
            # Add to database (exception will be thrown from database if smth is wrong)
            db_session.add(entity)
            db_session.commit()
            # Respond to user with new ID
            response['count'] = 1
            response['entities'].append(entity.to_dict())
            response['status']['code'] = status_codes.CREATED
        except ModelInitializationError as initError:
            response['status']['code'] = status_codes.BAD_REQUEST
            response['status']['errors'] = initError.errors
        except IntegrityError as integrityError:
            response['status']['code'] = status_codes.INTERNAL_SERVER_ERROR
            response['status']['errors'].append(str(integrityError.orig))
        except ProgrammingError as programmingError:
            response['status']['code'] = status_codes.INTERNAL_SERVER_ERROR
            response['status']['errors'].append(str(programmingError.orig))

    return jsonify(response)
