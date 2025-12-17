from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from .models import User


class UserRegisterForm(UserCreationForm):
    """用户注册表单"""
    email = forms.EmailField(required=True, widget=forms.EmailInput(attrs={
        'class': 'form-control',
        'placeholder': '邮箱'
    }))
    student_id = forms.CharField(max_length=20, required=True, widget=forms.TextInput(attrs={
        'class': 'form-control',
        'placeholder': '学号'
    }))

    class Meta:
        model = User
        fields = ['username', 'student_id', 'email', 'password1', 'password2']
        widgets = {
            'username': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': '用户名'
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['password1'].widget.attrs.update({
            'class': 'form-control',
            'placeholder': '密码'
        })
        self.fields['password2'].widget.attrs.update({
            'class': 'form-control',
            'placeholder': '确认密码'
        })


class UserLoginForm(AuthenticationForm):
    """用户登录表单"""
    username = forms.CharField(widget=forms.TextInput(attrs={
        'class': 'form-control',
        'placeholder': '用户名'
    }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'class': 'form-control',
        'placeholder': '密码'
    }))


class UserProfileForm(forms.ModelForm):
    """用户资料编辑表单"""
    class Meta:
        model = User
        fields = ['email', 'phone', 'avatar']
        widgets = {
            'email': forms.EmailInput(attrs={
                'class': 'form-control',
                'placeholder': '邮箱'
            }),
            'phone': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': '联系方式'
            }),
            'avatar': forms.FileInput(attrs={
                'class': 'form-control'
            }),
        }
