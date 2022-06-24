from .service_api import ns as service_ns

from flask import Blueprint
from flask_restx import Api

blueprint = Blueprint("restapi", __name__)

api = Api(
    blueprint, title="FLASK RESTX API", version="1.0", description="FLASK RESTX API "
)

api.add_namespace(service_ns, path="/service")


