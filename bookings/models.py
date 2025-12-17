from django.db import models
from django.conf import settings
from django.utils import timezone
from rooms.models import Seat, StudyRoom

# Create your models here.

class Booking(models.Model):
    """
    预约表
    """
    STATUS_CHOICES = (
        ('pending', '待审核'),
        ('approved', '已通过'),
        ('rejected', '已拒绝'),
        ('completed', '已完成'),
        ('cancelled', '已取消'),
        ('expired', '已过期'),
    )

    TIME_SLOT_CHOICES = (
        ('morning', '上午 (08:00-12:00)'),
        ('afternoon', '下午 (13:00-17:00)'),
        ('evening', '晚上 (18:00-22:00)'),
    )

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name='预约用户')
    seat = models.ForeignKey(Seat, on_delete=models.CASCADE, verbose_name='座位')
    booking_date = models.DateField('预约日期')
    time_slot = models.CharField('时段', max_length=20, choices=TIME_SLOT_CHOICES)
    status = models.CharField('状态', max_length=20, choices=STATUS_CHOICES, default='approved')
    note = models.TextField('备注', blank=True)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)

    class Meta:
        verbose_name = '预约'
        verbose_name_plural = '预约'
        ordering = ['-booking_date', '-created_at']
        unique_together = ['seat', 'booking_date', 'time_slot']

    def __str__(self):
        return f"{self.user.username} - {self.seat} - {self.booking_date} {self.get_time_slot_display()}"

    def is_expired(self):
        """检查预约是否已过期"""
        if self.booking_date < timezone.now().date():
            return True
        return False

    def can_checkin(self):
        """检查是否可以签到"""
        now = timezone.now()
        if self.booking_date != now.date():
            return False
        if self.status != 'approved':
            return False

        current_hour = now.hour
        if self.time_slot == 'morning' and 8 <= current_hour < 12:
            return True
        elif self.time_slot == 'afternoon' and 13 <= current_hour < 17:
            return True
        elif self.time_slot == 'evening' and 18 <= current_hour < 22:
            return True
        return False


class CheckIn(models.Model):
    """
    签到表
    """
    booking = models.OneToOneField(Booking, on_delete=models.CASCADE, verbose_name='预约')
    checkin_time = models.DateTimeField('签到时间', auto_now_add=True)
    checkout_time = models.DateTimeField('签退时间', null=True, blank=True)
    duration = models.IntegerField('使用时长(分钟)', default=0)
    note = models.TextField('备注', blank=True)

    class Meta:
        verbose_name = '签到记录'
        verbose_name_plural = '签到记录'
        ordering = ['-checkin_time']

    def __str__(self):
        return f"{self.booking.user.username} - {self.checkin_time.strftime('%Y-%m-%d %H:%M')}"

    def checkout(self):
        """签退"""
        self.checkout_time = timezone.now()
        self.duration = int((self.checkout_time - self.checkin_time).total_seconds() / 60)
        self.save()
