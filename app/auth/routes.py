from flask import render_template, redirect, url_for, flash, request
from flask_login import login_user, logout_user, login_required, current_user
from werkzeug.security import check_password_hash
from . import auth_bp
from app.models import User
from functools import wraps

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(username=username).first()
        if user and check_password_hash(user.password, password):
            login_user(user, remember='remember' in request.form)
            return redirect(url_for('main.index'))
        flash('Невозможно аутентифицироваться с указанными логином и паролем', 'danger')
    return render_template('auth/login.html')

@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('main.index'))

def login_required_with_flash(func):
    @wraps(func)
    def decorated_view(*args, **kwargs):
        if not current_user.is_authenticated:
            flash('Для выполнения данного действия необходимо пройти процедуру аутентификации', 'warning')
            return redirect(url_for('auth.login', next=request.url))
        return func(*args, **kwargs)
    return decorated_view 