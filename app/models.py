from .extensions import db
from flask_login import UserMixin
from datetime import datetime

class Role(db.Model):
    __tablename__ = 'roles'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), nullable=False, unique=True)
    description = db.Column(db.Text, nullable=False)

class User(UserMixin, db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), nullable=False, unique=True)
    password = db.Column(db.Text, nullable=False)
    last_name = db.Column(db.String(64), nullable=False)
    first_name = db.Column(db.String(64), nullable=False)
    middle_name = db.Column(db.String(64))
    role_id = db.Column(db.Integer, db.ForeignKey('roles.id'), nullable=False)
    role = db.relationship('Role', backref='users')

class Event(db.Model):
    __tablename__ = 'events'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(128), nullable=False)
    description = db.Column(db.Text, nullable=False)
    date = db.Column(db.Date, nullable=False)
    location = db.Column(db.String(128), nullable=False)
    required_volunteers = db.Column(db.Integer, nullable=False)
    image_filename = db.Column(db.String(128), nullable=False)
    organizer_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    organizer = db.relationship('User', backref='organized_events')

class Registration(db.Model):
    __tablename__ = 'registrations'
    id = db.Column(db.Integer, primary_key=True)
    event_id = db.Column(db.Integer, db.ForeignKey('events.id', ondelete='CASCADE'), nullable=False)
    volunteer_id = db.Column(db.Integer, db.ForeignKey('users.id', ondelete='CASCADE'), nullable=False)
    contact_info = db.Column(db.String(128), nullable=False)
    registration_date = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    status = db.Column(db.String(16), nullable=False, default='pending')
    event = db.relationship('Event', backref='registrations')
    volunteer = db.relationship('User', backref='registrations') 