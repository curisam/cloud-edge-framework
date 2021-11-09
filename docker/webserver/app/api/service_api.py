from flask_restx import Namespace, Resource, fields
from app.model import service_model
from flask import request


ns = Namespace("Service api", description="Service related operations")

@ns.route("/start", methods=['GET'])
@ns.doc("start service")
class startService (Resource):
    def get(self):

        """Start Service"""
        return service_model.start_service()


@ns.route("/status", methods=['GET'])
@ns.doc("get status of service")
class statusService (Resource):
    def get(self):

        """Status Service"""
        return service_model.get_status()
