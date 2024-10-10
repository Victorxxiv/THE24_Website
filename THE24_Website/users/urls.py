# from django.urls import path
# from .views import register, profile
# from django.contrib.auth import views as auth_views

# app_name = 'users'

# urlpatterns = [
    # User registration
    # path('register/', register, name='register'),

    # User profile
    # path('profile/', profile, name='profile'),

    # Additional user-related views
    # path('profile/edit/', profile_edit, name='profile_edit'),  # Edit user profile
    # path('delete/', account_delete, name='account_delete'),    # Delete user account

    # Authentication views
    # path('login/', auth_views.LoginView.as_view(template_name='users/login.html'), name='login'),
    # path('logout/', auth_views.LogoutView.as_view(template_name='users/logout.html'), name='logout'),

    # Password reset views
    # path('password-reset/', auth_views.PasswordResetView.as_view(template_name='users/password_reset.html'), name='password_reset'),
    # path('password-reset/done/', auth_views.PasswordResetDoneView.as_view(template_name='users/password_reset_done.html'), name='password_reset_done'),
    # path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(template_name='users/password_reset_confirm.html'), name='password_reset_confirm'),
    # path('reset/done/', auth_views.PasswordResetCompleteView.as_view(template_name='users/password_reset_complete.html'), name='password_reset_complete'),
# ]

