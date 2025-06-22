from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired, Length

class RegistrationForm(FlaskForm):
    contact_info = StringField('Контактная информация', validators=[DataRequired(), Length(max=128)])
    submit = SubmitField('Отправить заявку') 