# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""

import os
from decouple import config

class Config(object):
    basedir    = os.path.abspath(os.path.dirname(__file__))


class ProductionConfig(Config):
    DEBUG = False
    RUNNING_COUNT = 5

    

class DevelopmentConfig(Config):
    DEBUG = True
    RUNNING_COUNT = 5

    

# Load all possible configurations
config_dict = {
    'Prd' : ProductionConfig,
    'Dev' : DevelopmentConfig
}
