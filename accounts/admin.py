from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import User, BlackList

# Register your models here.

@admin.register(User)
class UserAdmin(BaseUserAdmin):
    list_display = ['username', 'student_id', 'email', 'role', 'is_banned', 'created_at']
    list_filter = ['role', 'is_banned', 'is_active', 'created_at']
    search_fields = ['username', 'student_id', 'email']
    ordering = ['-created_at']

    fieldsets = BaseUserAdmin.fieldsets + (
        ('额外信息', {'fields': ('student_id', 'phone', 'avatar', 'role', 'is_banned')}),
    )

    add_fieldsets = BaseUserAdmin.add_fieldsets + (
        ('额外信息', {'fields': ('student_id', 'email', 'phone', 'role')}),
    )


@admin.register(BlackList)
class BlackListAdmin(admin.ModelAdmin):
    list_display = ['user', 'reason', 'banned_by', 'banned_at', 'is_active']
    list_filter = ['is_active', 'banned_at']
    search_fields = ['user__username', 'user__student_id', 'reason']
    ordering = ['-banned_at']
    readonly_fields = ['banned_at']
