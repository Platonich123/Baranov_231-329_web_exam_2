"""add demo users

Revision ID: add_demo_users
Revises: a68b12daba13
Create Date: 2025-06-21 18:00:00

"""
from alembic import op
import sqlalchemy as sa
from werkzeug.security import generate_password_hash

revision = 'add_demo_users'
down_revision = 'a68b12daba13'
branch_labels = None
depends_on = None

def upgrade():
    connection = op.get_bind()
    # Получаем id ролей
    admin_role_id = connection.execute(sa.text("SELECT id FROM roles WHERE name='admin' LIMIT 1")).scalar()
    moderator_role_id = connection.execute(sa.text("SELECT id FROM roles WHERE name='moderator' LIMIT 1")).scalar()
    user_role_id = connection.execute(sa.text("SELECT id FROM roles WHERE name='user' LIMIT 1")).scalar()
    # Добавляем пользователей
    connection.execute(sa.text(
        """
        INSERT INTO users (username, password, last_name, first_name, middle_name, role_id)
        VALUES
        ('adminuser', :admin_pass, 'Админов', 'Админ', 'Админович', :admin_role_id),
        ('moduser', :mod_pass, 'Модератов', 'Модератор', 'Модераторович', :moderator_role_id)
        """
    ), {
        'admin_pass': generate_password_hash('ricky123'),
        'mod_pass': generate_password_hash('kanmaker332'),
        'admin_role_id': admin_role_id,
        'moderator_role_id': moderator_role_id
    })

def downgrade():
    op.execute("DELETE FROM users WHERE username IN ('adminuser', 'moduser')") 