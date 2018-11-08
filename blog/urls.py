#coding=utf-8
from django.conf.urls import url
from blog.views import *

urlpatterns = [
    url(r'^$', index, name='index'),
    # 映射到归档页面
    url(r'^archive/', archive, name='archive'),
    # 映射到文章页面
    url(r'^article/$', article, name='article'),
    # 映射到提交评论页面
    url(r'^comment/post/$', comment_post, name='comment_post'),
    # 映射到标签页面
    url(r'^tag/', tag, name='tag'),
    # 映射到分类页面
    url(r'^category/$', category, name='category'),
    # 登录注册注销
    url(r'^logout$', do_logout, name='logout'),
    url(r'^login$', do_login, name='login'),
    url(r'^reg$', do_reg, name='reg'),
    url(r'^search/$', search, name="search"),
]
