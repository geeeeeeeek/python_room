from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import UserRegisterForm, UserLoginForm, UserProfileForm

# Create your views here.

def register(request):
    """用户注册"""
    if request.user.is_authenticated:
        return redirect('home')

    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            messages.success(request, f'欢迎 {user.username}！您已成功注册并登录。')
            return redirect('home')
    else:
        form = UserRegisterForm()

    return render(request, 'accounts/register.html', {'form': form})


def user_login(request):
    """用户登录"""
    if request.user.is_authenticated:
        return redirect('home')

    if request.method == 'POST':
        form = UserLoginForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(username=username, password=password)
            if user is not None:
                if user.is_banned:
                    messages.error(request, '您的账号已被封禁，无法登录。')
                else:
                    login(request, user)
                    messages.success(request, f'欢迎回来，{username}！')
                    next_url = request.GET.get('next', 'home')
                    return redirect(next_url)
    else:
        form = UserLoginForm()

    return render(request, 'accounts/login.html', {'form': form})


@login_required
def user_logout(request):
    """用户登出"""
    logout(request)
    messages.info(request, '您已成功退出登录。')
    return redirect('home')


@login_required
def profile(request):
    """用户个人资料"""
    if request.method == 'POST':
        form = UserProfileForm(request.POST, request.FILES, instance=request.user)
        if form.is_valid():
            form.save()
            messages.success(request, '个人资料已更新。')
            return redirect('profile')
    else:
        form = UserProfileForm(instance=request.user)

    return render(request, 'accounts/profile.html', {'form': form})
