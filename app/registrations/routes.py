from flask import render_template, redirect, url_for, flash, request, abort, jsonify
from flask_login import login_required, current_user
from . import registrations_bp
from app.models import Event, Registration
from app.extensions import db
from datetime import datetime
from .forms import RegistrationForm
from app.auth.routes import login_required_with_flash

@registrations_bp.route('/events/<int:event_id>/register', methods=['GET', 'POST'])
@login_required_with_flash
def register(event_id):
    event = Event.query.get_or_404(event_id)
    if current_user.role.name != 'user':
        flash('Только пользователи могут регистрироваться как волонтёры.', 'danger')
        return redirect(url_for('events.view_event', event_id=event_id))
    existing = Registration.query.filter_by(event_id=event_id, volunteer_id=current_user.id).first()
    if existing:
        flash('Вы уже подали заявку на это мероприятие.', 'info')
        return redirect(url_for('events.view_event', event_id=event_id))
    form = RegistrationForm()
    if form.validate_on_submit():
        reg = Registration(
            event_id=event_id,
            volunteer_id=current_user.id,
            contact_info=form.contact_info.data,
            status='pending'
        )
        db.session.add(reg)
        try:
            db.session.commit()
            flash('Заявка отправлена!', 'success')
            return redirect(url_for('events.view_event', event_id=event_id))
        except Exception as e:
            db.session.rollback()
            flash('Ошибка при отправке заявки.', 'danger')
    return render_template('registrations/registration_modal.html', form=form, event=event)

@registrations_bp.route('/registrations/<int:reg_id>/accept', methods=['POST'])
@login_required_with_flash
def accept(reg_id):
    reg = Registration.query.get_or_404(reg_id)
    event = reg.event
    if current_user.role.name != 'moderator':
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('events.view_event', event_id=event.id))
    accepted_count = Registration.query.filter_by(event_id=event.id, status='accepted').count()
    if accepted_count >= event.required_volunteers:
        flash('Требуемое количество волонтёров уже набрано.', 'info')
        return redirect(url_for('events.view_event', event_id=event.id))
    reg.status = 'accepted'
    db.session.commit()
    # Если после принятия заявки лимит достигнут, отклоняем остальные
    accepted_count = Registration.query.filter_by(event_id=event.id, status='accepted').count()
    if accepted_count >= event.required_volunteers:
        pending_regs = Registration.query.filter_by(event_id=event.id, status='pending').all()
        for r in pending_regs:
            r.status = 'rejected'
        db.session.commit()
    flash('Заявка принята.', 'success')
    return redirect(url_for('events.view_event', event_id=event.id))

@registrations_bp.route('/registrations/<int:reg_id>/reject', methods=['POST'])
@login_required_with_flash
def reject(reg_id):
    reg = Registration.query.get_or_404(reg_id)
    event = reg.event
    if current_user.role.name != 'moderator':
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('events.view_event', event_id=event.id))
    reg.status = 'rejected'
    db.session.commit()
    flash('Заявка отклонена.', 'info')
    return redirect(url_for('events.view_event', event_id=event.id))

@registrations_bp.route('/registrations/<int:reg_id>/delete', methods=['POST'])
@login_required_with_flash
def delete_registration(reg_id):
    reg = Registration.query.get_or_404(reg_id)
    event = reg.event
    
    # Проверяем права доступа: пользователь может удалить свою регистрацию, модератор - любую
    if current_user.role.name not in ['moderator', 'admin'] and current_user.id != reg.volunteer_id:
        flash('У вас недостаточно прав для выполнения данного действия', 'danger')
        return redirect(url_for('events.view_event', event_id=event.id))
    
    try:
        db.session.delete(reg)
        db.session.commit()
        flash('Регистрация успешно удалена!', 'success')
    except Exception as e:
        db.session.rollback()
        flash('Ошибка при удалении регистрации.', 'danger')
    
    return redirect(url_for('events.view_event', event_id=event.id)) 