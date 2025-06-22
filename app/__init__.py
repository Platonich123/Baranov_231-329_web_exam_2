from flask import Flask
from .extensions import db, migrate, login_manager
from .models import User
from .main import main_bp
from .auth import auth_bp
from .events import events_bp
from .registrations import registrations_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object('config.Config')
    db.init_app(app)
    migrate.init_app(app, db)
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    app.register_blueprint(main_bp)
    app.register_blueprint(auth_bp)
    app.register_blueprint(events_bp)
    app.register_blueprint(registrations_bp)
    return app 