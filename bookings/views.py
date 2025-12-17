from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from django.db.models import Q, Count
from datetime import timedelta
from .models import Booking, CheckIn
from .forms import BookingForm
from rooms.models import StudyRoom, Seat

# Create your views here.

@login_required
def create_booking(request, room_id):
    """创建预约"""
    room = get_object_or_404(StudyRoom, id=room_id)

    # 检查用户是否被封禁
    if request.user.is_banned:
        messages.error(request, '您的账号已被封禁，无法进行预约。')
        return redirect('room_detail', room_id=room_id)

    # 检查今日预约次数限制（每日最多3次）
    today = timezone.now().date()
    today_bookings_count = Booking.objects.filter(
        user=request.user,
        booking_date=today,
        status='approved'
    ).count()

    if today_bookings_count >= 3:
        messages.error(request, '您今日的预约次数已达到上限（3次）。')
        return redirect('room_detail', room_id=room_id)

    if request.method == 'POST':
        form = BookingForm(request.POST, room=room)
        if form.is_valid():
            booking = form.save(commit=False)
            booking.user = request.user

            # 检查是否已有相同座位、日期和时段的预约
            existing_booking = Booking.objects.filter(
                seat=booking.seat,
                booking_date=booking.booking_date,
                time_slot=booking.time_slot,
                status='approved'
            ).exists()

            if existing_booking:
                messages.error(request, '该座位在所选时段已被预约。')
            else:
                booking.save()
                messages.success(request, '预约成功！请记得在预约时段签到。')
                return redirect('my_bookings')
    else:
        form = BookingForm(room=room)

    context = {
        'form': form,
        'room': room,
    }
    return render(request, 'bookings/create_booking.html', context)


@login_required
def my_bookings(request):
    """我的预约记录"""
    # 获取用户所有预约
    bookings = Booking.objects.filter(user=request.user).select_related(
        'seat', 'seat__room'
    ).order_by('-booking_date', '-created_at')

    # 分类预约
    today = timezone.now().date()
    upcoming = bookings.filter(booking_date__gte=today, status='approved')
    past = bookings.filter(
        Q(booking_date__lt=today) |
        Q(status__in=['completed', 'cancelled', 'expired'])
    )

    context = {
        'upcoming_bookings': upcoming,
        'past_bookings': past,
    }
    return render(request, 'bookings/my_bookings.html', context)


@login_required
def cancel_booking(request, booking_id):
    """取消预约"""
    booking = get_object_or_404(Booking, id=booking_id, user=request.user)

    if booking.status == 'approved':
        # 只能取消未来的预约
        if booking.booking_date >= timezone.now().date():
            booking.status = 'cancelled'
            booking.save()
            messages.success(request, '预约已取消。')
        else:
            messages.error(request, '无法取消过去的预约。')
    else:
        messages.error(request, '该预约无法取消。')

    return redirect('my_bookings')


@login_required
def checkin(request, booking_id):
    """签到"""
    booking = get_object_or_404(Booking, id=booking_id, user=request.user)

    # 检查是否可以签到
    if not booking.can_checkin():
        messages.error(request, '当前不在签到时间范围内，或预约状态不正确。')
        return redirect('my_bookings')

    # 检查是否已签到
    if hasattr(booking, 'checkin'):
        messages.warning(request, '您已签到过了。')
        return redirect('my_bookings')

    # 创建签到记录
    CheckIn.objects.create(booking=booking)
    booking.status = 'completed'
    booking.save()

    messages.success(request, '签到成功！祝您学习愉快。')
    return redirect('my_bookings')


@login_required
def my_checkins(request):
    """我的签到记录"""
    checkins = CheckIn.objects.filter(
        booking__user=request.user
    ).select_related('booking', 'booking__seat', 'booking__seat__room').order_by('-checkin_time')

    context = {
        'checkins': checkins,
    }
    return render(request, 'bookings/my_checkins.html', context)
