from django.shortcuts import render
from django.cotrib.auth.forms import UserCreateionForm

def register(request):
    form = UserCreateionForm()
    return render(request, 'users/register.html', {'form': form})