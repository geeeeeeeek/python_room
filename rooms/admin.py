from django.contrib import admin
from .models import StudyRoom, Seat

# Register your models here.

@admin.register(StudyRoom)
class StudyRoomAdmin(admin.ModelAdmin):
    list_display = ['name', 'location', 'total_seats', 'available_seats', 'status', 'open_time', 'close_time']
    list_filter = ['status', 'created_at']
    search_fields = ['name', 'location']
    ordering = ['name']
    readonly_fields = ['created_at', 'updated_at']

    fieldsets = (
        ('基本信息', {
            'fields': ('name', 'location', 'description', 'image')
        }),
        ('座位信息', {
            'fields': ('total_seats', 'available_seats')
        }),
        ('开放时间', {
            'fields': ('open_time', 'close_time', 'status')
        }),
        ('设施设备', {
            'fields': ('facilities',)
        }),
        ('时间戳', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )


@admin.register(Seat)
class SeatAdmin(admin.ModelAdmin):
    list_display = ['seat_number', 'room', 'row', 'column', 'status', 'has_power', 'has_lamp']
    list_filter = ['room', 'status', 'has_power', 'has_lamp']
    search_fields = ['seat_number', 'room__name']
    ordering = ['room', 'seat_number']
    readonly_fields = ['created_at', 'updated_at']

    fieldsets = (
        ('基本信息', {
            'fields': ('room', 'seat_number', 'row', 'column')
        }),
        ('状态和配置', {
            'fields': ('status', 'has_power', 'has_lamp', 'description')
        }),
        ('时间戳', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
