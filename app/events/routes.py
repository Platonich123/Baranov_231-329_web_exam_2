from flask import render_template, redirect, url_for, flash, request, abort
from flask_login import login_required, current_user
from . import events_bp
from app.models import Event, User, Registration
from app.extensions import db
from datetime import date
from .forms import EventForm
import os
from werkzeug.utils import secure_filename
import markdown
import bleach
from app.auth.routes import login_required_with_flash

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
UPLOAD_FOLDER = 'app/static/uploads'

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@events_bp.route('/events/create', methods=['GET', 'POST'])
@login_required_with_flash
def create_event():
    if current_user.role.name != 'admin':
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('main.index'))
    form = EventForm()
    if form.validate_on_submit():
        file = form.image.data
        if not file or not allowed_file(file.filename):
            flash('Пожалуйста, выберите изображение в формате png, jpg, jpeg или gif.', 'danger')
            return render_template('events/event_form.html', form=form)
        filename = secure_filename(file.filename)
        os.makedirs(UPLOAD_FOLDER, exist_ok=True)
        file.save(os.path.join(UPLOAD_FOLDER, filename))
        clean_description = bleach.clean(form.description.data)
        event = Event(
            title=form.title.data,
            description=clean_description,
            date=form.date.data,
            location=form.location.data,
            required_volunteers=form.required_volunteers.data,
            image_filename=filename,
            organizer_id=current_user.id
        )
        db.session.add(event)
        try:
            db.session.commit()
            flash('Мероприятие успешно создано!', 'success')
            return redirect(url_for('main.index'))
        except Exception as e:
            db.session.rollback()
            flash('При сохранении данных возникла ошибка. Проверьте корректность введённых данных.', 'danger')
    return render_template('events/event_form.html', form=form)

@events_bp.route('/events/<int:event_id>')
def view_event(event_id):
    event = Event.query.get_or_404(event_id)
    html_description = markdown.markdown(event.description)
    registration = None
    can_register = False
    can_see_volunteers = False
    can_moderate = False
    if current_user.is_authenticated:
        if current_user.role.name == 'user':
            registration = Registration.query.filter_by(event_id=event_id, volunteer_id=current_user.id).first()
            can_register = True
        if current_user.role.name in ['admin', 'moderator']:
            can_see_volunteers = True
        if current_user.role.name == 'moderator':
            can_moderate = True
    return render_template('events/event_view.html', event=event, html_description=html_description, registration=registration, can_register=can_register, can_see_volunteers=can_see_volunteers, can_moderate=can_moderate)

@events_bp.route('/events/<int:event_id>/edit', methods=['GET', 'POST'])
@login_required_with_flash
def edit_event(event_id):
    event = Event.query.get_or_404(event_id)
    if current_user.role.name not in ['admin', 'moderator']:
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('main.index'))
    form = EventForm(obj=event)
    # Не даём менять изображение при редактировании
    del form.image
    if form.validate_on_submit():
        event.title = form.title.data
        event.description = bleach.clean(form.description.data)
        event.date = form.date.data
        event.location = form.location.data
        event.required_volunteers = form.required_volunteers.data
        try:
            db.session.commit()
            flash('Мероприятие успешно обновлено!', 'success')
            return redirect(url_for('events.view_event', event_id=event.id))
        except Exception as e:
            db.session.rollback()
            flash('При сохранении данных возникла ошибка. Проверьте корректность введённых данных.', 'danger')
    return render_template('events/event_form.html', form=form, edit=True)

@events_bp.route('/events/<int:event_id>/delete', methods=['POST'])
@login_required_with_flash
def delete_event(event_id):
    event = Event.query.get_or_404(event_id)
    if current_user.role.name != 'admin':
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('main.index'))
    try:
        db.session.delete(event)
        db.session.commit()
        flash('Мероприятие успешно удалено!', 'success')
    except Exception as e:
        db.session.rollback()
        flash('Ошибка при удалении мероприятия.', 'danger')
    return redirect(url_for('main.index')) 
