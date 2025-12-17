from django.contrib import admin
from .models import Booking, CheckIn

# Register your models here.

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ['user', 'seat', 'booking_date', 'time_slot', 'status', 'created_at']
    list_filter = ['status', 'time_slot', 'booking_date', 'created_at']
    search_fields = ['user__username', 'user__student_id', 'seat__seat_number', 'seat__room__name']
    ordering = ['-booking_date', '-created_at']
    readonly_fields = ['created_at', 'updated_at']
    date_hierarchy = 'booking_date'

    fieldsets = (
        ('预约信息', {
            'fields': ('user', 'seat', 'booking_date', 'time_slot')
        }),
        ('状态和备注', {
            'fields': ('status', 'note')
        }),
        ('时间戳', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )


@admin.register(CheckIn)
class CheckInAdmin(admin.ModelAdmin):
    list_display = ['booking', 'checkin_time', 'checkout_time', 'duration']
    list_filter = ['checkin_time', 'checkout_time']
    search_fields = ['booking__user__username', 'booking__seat__seat_number']
    ordering = ['-checkin_time']
    readonly_fields = ['checkin_time']
    date_hierarchy = 'checkin_time'

    fieldsets = (
        ('签到信息', {
            'fields': ('booking',)
        }),
        ('时间信息', {
            'fields': ('checkin_time', 'checkout_time', 'duration')
        }),
        ('备注', {
            'fields': ('note',)
        }),
    )
