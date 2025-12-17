from django.db import models

# Create your models here.

class StudyRoom(models.Model):
    """
    自习室表
    """
    STATUS_CHOICES = (
        ('open', '开放'),
        ('closed', '关闭'),
        ('maintenance', '维护中'),
    )

    name = models.CharField('自习室名称', max_length=100)
    location = models.CharField('位置', max_length=200)
    description = models.TextField('描述', blank=True)
    image = models.ImageField('图片', upload_to='room_images/', blank=True, null=True)
    total_seats = models.IntegerField('总座位数', default=0)
    available_seats = models.IntegerField('可用座位数', default=0)
    open_time = models.TimeField('开放时间', default='08:00:00')
    close_time = models.TimeField('关闭时间', default='22:00:00')
    status = models.CharField('状态', max_length=20, choices=STATUS_CHOICES, default='open')
    facilities = models.TextField('设备设施', blank=True, help_text='空调、插座、WiFi等')
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)

    class Meta:
        verbose_name = '自习室'
        verbose_name_plural = '自习室'
        ordering = ['name']

    def __str__(self):
        return self.name

    def update_available_seats(self):
        """更新可用座位数"""
        self.available_seats = self.seat_set.filter(status='available').count()
        self.save()


class Seat(models.Model):
    """
    座位表
    """
    STATUS_CHOICES = (
        ('available', '可预约'),
        ('occupied', '已预约'),
        ('unavailable', '不可用'),
    )

    room = models.ForeignKey(StudyRoom, on_delete=models.CASCADE, verbose_name='所属自习室')
    seat_number = models.CharField('座位号', max_length=20)
    row = models.IntegerField('行号', default=1)
    column = models.IntegerField('列号', default=1)
    status = models.CharField('状态', max_length=20, choices=STATUS_CHOICES, default='available')
    has_power = models.BooleanField('是否有电源', default=True)
    has_lamp = models.BooleanField('是否有台灯', default=False)
    description = models.TextField('描述', blank=True)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)

    class Meta:
        verbose_name = '座位'
        verbose_name_plural = '座位'
        ordering = ['room', 'seat_number']
        unique_together = ['room', 'seat_number']

    def __str__(self):
        return f"{self.room.name} - {self.seat_number}"
