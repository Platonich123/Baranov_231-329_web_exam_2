from flask import Blueprint

registrations_bp = Blueprint('registrations', __name__)

from . import routes 