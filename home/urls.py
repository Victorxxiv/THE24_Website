from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),  # This maps the home view to the root URL
]
