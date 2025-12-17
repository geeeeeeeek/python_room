from django import forms
from django.utils import timezone
from .models import Booking


class BookingForm(forms.ModelForm):
    """预约表单"""
    class Meta:
        model = Booking
        fields = ['seat', 'booking_date', 'time_slot', 'note']
        widgets = {
            'seat': forms.Select(attrs={
                'class': 'form-control',
            }),
            'booking_date': forms.DateInput(attrs={
                'class': 'form-control',
                'type': 'date',
                'min': timezone.now().date().isoformat()
            }),
            'time_slot': forms.Select(attrs={
                'class': 'form-control',
            }),
            'note': forms.Textarea(attrs={
                'class': 'form-control',
                'rows': 3,
                'placeholder': '备注信息（可选）'
            }),
        }

    def __init__(self, *args, **kwargs):
        room = kwargs.pop('room', None)
        super().__init__(*args, **kwargs)

        if room:
            # 只显示该自习室的可用座位
            self.fields['seat'].queryset = room.seat_set.filter(status='available')
