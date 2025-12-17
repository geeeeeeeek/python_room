from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from .models import StudyRoom, Seat
from bookings.models import Booking

# Create your views here.

def home(request):
    """首页"""
    rooms = StudyRoom.objects.filter(status='open').order_by('name')
    return render(request, 'home.html', {'rooms': rooms})


def room_list(request):
    """自习室列表"""
    rooms = StudyRoom.objects.all().order_by('name')
    return render(request, 'rooms/room_list.html', {'rooms': rooms})


def room_detail(request, room_id):
    """自习室详情页"""
    room = get_object_or_404(StudyRoom, id=room_id)
    seats = room.seat_set.all().order_by('row', 'column')

    # 获取今天的预约情况
    today = timezone.now().date()
    today_bookings = Booking.objects.filter(
        seat__room=room,
        booking_date=today,
        status='approved'
    ).select_related('seat', 'user')

    # 构建座位预约状态字典
    seat_bookings = {}
    for booking in today_bookings:
        if booking.seat_id not in seat_bookings:
            seat_bookings[booking.seat_id] = []
        seat_bookings[booking.seat_id].append(booking)

    context = {
        'room': room,
        'seats': seats,
        'seat_bookings': seat_bookings,
    }
    return render(request, 'rooms/room_detail.html', context)


def seat_detail(request, seat_id):
    """座位详情页"""
    seat = get_object_or_404(Seat, id=seat_id)

    # 获取该座位未来7天的预约情况
    today = timezone.now().date()
    bookings = Booking.objects.filter(
        seat=seat,
        booking_date__gte=today,
        status='approved'
    ).order_by('booking_date', 'time_slot')[:20]

    context = {
        'seat': seat,
        'bookings': bookings,
    }
    return render(request, 'rooms/seat_detail.html', context)
