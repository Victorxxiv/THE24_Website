from django.db import models
from django.contrib.auth.models import User

# Create profile model
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    image = models.ImageField(default='default.jpg', upload_to='profile_pics')
    bio = models.TextField(blank=True, null=True)  # Allows bio to be empty
    city = models.CharField(max_length=100, blank=True, null=True)  # City name

    def __str__(self):
        return f'{self.user.username} Profile'