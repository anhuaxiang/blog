# coding=utf-8
from django.contrib import admin
from django.contrib.auth.models import Permission

from blog.models import *


# Register your models here.
class ArticleAdmin(admin.ModelAdmin):
    # 决定哪些是展开显示，哪些合并在一起
    fieldsets = (
        # 这些展开
        (None, {
            'fields': ('title', 'desc', 'content', 'user', 'tag', 'category',)
        }
         ),
        # 这些默认合并
        ('高级设置', {
            'classes': ('collapse',),
            'fields': ('click_count', 'is_recommend',)
        }
         ),
    )
    # 定义显示已保存文章的哪些字段
    list_display = ('title', 'desc', 'click_count',)
    # 定义是否显示链接
    list_display_links = ('title', 'desc',)
    # 设置哪些字段可以直接编辑
    list_editable = ('click_count',)
    # 定义可以按照哪些字段分列
    list_filter = ('title', 'desc', 'click_count',)

    # 引入富文本编辑器的类
    class Media:
        js = (
            # 核心文件
            '/static/js/kindeditor-4.1.10/kindeditor-min.js',
            # 引入中文语言文件
            '/static/js/kindeditor-4.1.10/lang/zh_CN.js',
            # 引入配置文件
            '/static/js/kindeditor-4.1.10/config.js',
        )


admin.site.register(User)
admin.site.register(Tag)
# 改成自定义形式注册
admin.site.register(Article, ArticleAdmin)
admin.site.register(Category)
admin.site.register(Comment)
admin.site.register(Links)
admin.site.register(Ad)
admin.site.register(Permission)