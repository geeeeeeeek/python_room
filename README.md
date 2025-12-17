# 大学生自习室预约系统

这是一个基于 Django 开发的大学生自习室预约系统，支持用户注册登录、自习室浏览、座位预约、签到等功能。

## 功能特性

### 用户功能
- ✅ 用户注册与登录（学号、邮箱）
- ✅ 个人资料管理（昵称、联系方式、头像）
- ✅ 浏览自习室列表及详情
- ✅ 查看座位布局和实时状态
- ✅ 在线预约座位（按日期和时段）
- ✅ 查看我的预约记录
- ✅ 取消预约
- ✅ 预约签到功能
- ✅ 查看签到记录

### 管理员功能
- ✅ 自习室管理（增删改查）
- ✅ 座位管理（批量操作、状态设置）
- ✅ 用户管理（封禁、解禁）
- ✅ 预约管理（审核、查看）
- ✅ 签到记录查看
- ✅ 黑名单管理

### 预约规则
- 每人每日最多可预约 3 个时段
- 预约时段：上午(08:00-12:00)、下午(13:00-17:00)、晚上(18:00-22:00)
- 需在预约时段内签到，否则预约自动过期
- 可提前取消不需要的预约

## 技术栈

- **后端框架**: Django 3.2
- **数据库**: MySQL 5.7+
- **前端**: Bootstrap 5 + jQuery
- **Python**: 3.8+

## 项目结构

```
study_room_booking/
├── accounts/               # 用户管理应用
│   ├── models.py          # 用户模型、黑名单模型
│   ├── views.py           # 注册、登录、个人资料视图
│   ├── forms.py           # 用户表单
│   └── admin.py           # Admin后台配置
├── rooms/                 # 自习室管理应用
│   ├── models.py          # 自习室、座位模型
│   ├── views.py           # 自习室列表、详情视图
│   └── admin.py           # Admin后台配置
├── bookings/              # 预约管理应用
│   ├── models.py          # 预约、签到模型
│   ├── views.py           # 预约、签到视图
│   ├── forms.py           # 预约表单
│   └── admin.py           # Admin后台配置
├── templates/             # 模板文件
│   ├── base.html          # 基础模板
│   ├── home.html          # 首页
│   ├── accounts/          # 用户相关模板
│   ├── rooms/             # 自习室相关模板
│   └── bookings/          # 预约相关模板
├── static/                # 静态文件
│   ├── css/               # 样式文件
│   ├── js/                # JavaScript文件
│   └── images/            # 图片资源
├── media/                 # 媒体文件（用户上传）
│   ├── avatars/           # 用户头像
│   └── room_images/       # 自习室图片
└── study_room_booking/    # 项目配置
    ├── settings.py        # 项目设置
    ├── urls.py            # URL路由
    └── wsgi.py            # WSGI配置
```

## 安装部署

### 1. 环境要求

- Python 3.8+
- MySQL 5.7+
- pip

### 2. 克隆项目

```bash
cd /path/to/your/project
```

### 3. 安装依赖

```bash
pip install -r requirements.txt
```

### 4. 配置数据库

创建 MySQL 数据库：

```sql
CREATE DATABASE study_room_booking CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

修改 `study_room_booking/settings.py` 中的数据库配置：

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'study_room_booking',
        'USER': 'your_mysql_user',
        'PASSWORD': 'your_mysql_password',
        'HOST': 'localhost',
        'PORT': '3306',
        'OPTIONS': {
            'charset': 'utf8mb4',
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
        }
    }
}
```

### 5. 执行数据库迁移

```bash
python manage.py makemigrations
python manage.py migrate
```

### 6. 创建超级管理员

```bash
python manage.py createsuperuser
```

按提示输入用户名、学号、邮箱和密码。


### 7. 运行开发服务器

```bash
python manage.py runserver 0.0.0.0:8000
```

访问 `http://localhost:8000` 查看系统。

## 使用说明

### 普通用户

1. **注册账号**: 访问首页点击"注册"，填写学号、邮箱等信息
2. **浏览自习室**: 登录后可查看所有开放的自习室
3. **预约座位**: 选择自习室 → 查看座位布局 → 点击"预约座位"按钮
4. **管理预约**: 在"我的预约"页面可查看、取消预约
5. **签到**: 到达自习室后，在预约时段内点击"签到"按钮
6. **查看记录**: 在"签到记录"页面查看历史学习记录

### 管理员

1. **登录后台**: 访问 `http://localhost:8000/admin`
2. **管理自习室**: 添加/编辑自习室信息、设置开放时间
3. **管理座位**: 批量添加座位、设置座位状态和配置
4. **用户管理**: 查看用户信息、封禁违规用户
5. **预约管理**: 查看所有预约记录、处理异常预约
6. **数据统计**: 查看座位利用率、活跃用户等数据

## 数据库设计

### 主要数据表

- `accounts_user`: 用户表（扩展自Django User）
- `accounts_blacklist`: 黑名单表
- `rooms_studyroom`: 自习室表
- `rooms_seat`: 座位表
- `bookings_booking`: 预约表
- `bookings_checkin`: 签到表

### 关系说明

- 一个自习室有多个座位（一对多）
- 一个用户可以有多个预约（一对多）
- 一个座位可以有多个预约（一对多）
- 一个预约对应一个签到记录（一对一）

## 开发说明

### 添加新功能

1. 在对应的 app 中创建模型
2. 生成并执行迁移文件
3. 创建视图函数和表单
4. 配置 URL 路由
5. 创建模板页面
6. 注册到 Admin 后台

### 代码规范

- 遵循 PEP 8 Python 编码规范
- 模型、视图、表单分离
- 使用 Django 的类视图（可选）
- 添加必要的注释和文档字符串

## 常见问题

### 1. 数据库连接错误

检查 MySQL 服务是否启动，数据库配置是否正确。

### 2. 静态文件无法加载

确保执行了 `collectstatic` 命令，并检查 `STATIC_ROOT` 配置。

### 3. 图片上传失败

检查 `MEDIA_ROOT` 目录权限，确保 Django 有写入权限。

### 4. 时区问题

系统默认使用 Asia/Shanghai 时区，可在 settings.py 中修改 `TIME_ZONE` 配置。


## 许可证

本项目仅供学习交流使用。

## 联系方式

如有问题或建议，欢迎提交 Issue。
