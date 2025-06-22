from flask import render_template, request
from flask_login import current_user
from . import main_bp
from app.models import Event
from datetime import date

@main_bp.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    events = Event.query.order_by(Event.date.desc()).paginate(page=page, per_page=6, error_out=False)
    show_add_button = current_user.is_authenticated and current_user.role.name == 'admin'
    return render_template('main/index.html', events=events, show_add_button=show_add_button) 