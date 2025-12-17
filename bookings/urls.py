from django.urls import path
from . import views

urlpatterns = [
    path('create/<int:room_id>/', views.create_booking, name='create_booking'),
    path('my-bookings/', views.my_bookings, name='my_bookings'),
    path('cancel/<int:booking_id>/', views.cancel_booking, name='cancel_booking'),
    path('checkin/<int:booking_id>/', views.checkin, name='checkin'),
    path('my-checkins/', views.my_checkins, name='my_checkins'),
]
