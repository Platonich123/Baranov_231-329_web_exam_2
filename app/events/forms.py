from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, DateField, IntegerField, FileField, SubmitField
from wtforms.validators import DataRequired, Length, NumberRange

class EventForm(FlaskForm):
    title = StringField('Название', validators=[DataRequired(), Length(max=128)])
    description = TextAreaField('Описание', validators=[DataRequired()])
    date = DateField('Дата', validators=[DataRequired()], format='%Y-%m-%d')
    location = StringField('Место', validators=[DataRequired(), Length(max=128)])
    required_volunteers = IntegerField('Требуемое количество волонтёров', validators=[DataRequired(), NumberRange(min=1)])
    image = FileField('Изображение')
    submit = SubmitField('Сохранить') 