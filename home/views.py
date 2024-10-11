from django.shortcuts import render
from blog.models import Post

def home(request):
    latest_posts = Post.objects.all().order_by('-date_posted')[:5] # Fetch latest posts for sidebar or section
    context = {
        'latest_posts': latest_posts  # Pass latest posts to the home template
    }
    return render(request, 'home/home.html', context)
