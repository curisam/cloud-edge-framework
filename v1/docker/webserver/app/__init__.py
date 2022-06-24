from flask import Flask
from app.api import blueprint as api
from flask_cors import CORS
import os


def create_app(config):
    app = Flask(__name__)

    CORS(app)
    app.config.from_object(config)

    # configure_database(app)

    app.register_blueprint(api, url_prefix="/rest/1.0")

    return app
