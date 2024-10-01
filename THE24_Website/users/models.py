from django.db import models
from django.contrib.auth.models import User
from PIL import Image

# Create profile model
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    image = models.ImageField(default='default.jpg', upload_to='profile_pics')
    bio = models.TextField(blank=True, null=True)  # Allows bio to be empty
    city = models.CharField(max_length=100, blank=True, null=True)  # City name

    def __str__(self):
        return f'{self.user.username} Profile'
    
    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)  # Ensure that args and kwargs are passed to the superclass
        
        # Resize image
        img = Image.open(self.image.path)

        if img.height > 300 or img.width > 300:
            output_size = (300, 300)
            img.thumbnail(output_size)
            img.save(self.image.path)