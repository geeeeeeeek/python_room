from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

class User(AbstractUser):
    """
    自定义用户模型
    """
    ROLE_CHOICES = (
        ('student', '学生'),
        ('admin', '管理员'),
    )

    student_id = models.CharField('学号', max_length=20, unique=True)
    email = models.EmailField('邮箱', unique=True)
    phone = models.CharField('联系方式', max_length=20, blank=True)
    avatar = models.ImageField('头像', upload_to='avatars/', blank=True, null=True)
    role = models.CharField('角色', max_length=10, choices=ROLE_CHOICES, default='student')
    is_banned = models.BooleanField('是否被封禁', default=False)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)

    class Meta:
        verbose_name = '用户'
        verbose_name_plural = '用户'
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.username} ({self.student_id})"


class BlackList(models.Model):
    """
    黑名单表
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='用户')
    reason = models.TextField('封禁原因')
    banned_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='banned_users', verbose_name='封禁操作人')
    banned_at = models.DateTimeField('封禁时间', auto_now_add=True)
    unbanned_at = models.DateTimeField('解封时间', null=True, blank=True)
    is_active = models.BooleanField('是否生效', default=True)

    class Meta:
        verbose_name = '黑名单'
        verbose_name_plural = '黑名单'
        ordering = ['-banned_at']

    def __str__(self):
        return f"{self.user.username} - {self.reason}"
