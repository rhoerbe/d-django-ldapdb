import django
django.setup()

from django.contrib.auth.models import User

u = User(username='admin')
u.set_password('changeit')
u.is_superuser = True
u.is_staff = True
u.save()
print('User admin created and password set')