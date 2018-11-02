# -*- coding:utf-8 -*-
import pdb
from django.db import models
from django.contrib.auth.models import AbstractUser


# Create your models here.
class Tag(models.Model):
    name = models.CharField(max_length=30, verbose_name='标签名称')

    # 方便在admin中查看名字
    class Meta:
        verbose_name = '标签'
        verbose_name_plural = verbose_name
        ordering = ['id']

    # 调用时返回自身的一些属性，注意python3用这个，python2用__unicode__
    def __unicode__(self):
        # 必须返回字符串类型，str(self.id)
        return self.name

    def __str__(self):
        return self.name


# 文章分类
class Category(models.Model):
    name = models.CharField(max_length=30, verbose_name='分类名称')
    # 排序属性
    index = models.IntegerField('显示顺序(从小到大)', default=999)

    class Meta:
        verbose_name = '分类'
        verbose_name_plural = verbose_name
        # 按照index和id属性排序
        ordering = ['index', 'id']

    def __unicode__(self):
        return self.name

    def __str__(self):
        return self.name


# 用户模型
# 继承方式扩展AbstractUser，可以使用django封装好的权限等属性
# 扩展：还可以用关联方式扩展用户信息，one to one
# 两者各有优劣
class User(AbstractUser):
    # 头像用图片类型
    avatar = models.ImageField( \
        upload_to='avatar/%Y/%m', default='avatar/default.png', \
        max_length=200, blank=True, null=True, verbose_name='用户头像')
    # 可以为空
    qq = models.CharField(max_length=20, blank=True, null=True, verbose_name='QQ号码')
    # 不能重复
    mobile = models.CharField(max_length=11, blank=True, null=True, unique=True, verbose_name='手机号码')
    # 新增字段
    url = models.URLField(max_length=100, blank=True, null=True, verbose_name='个人网页地址')

    class Meta:
        verbose_name = '用户'
        verbose_name_plural = verbose_name
        ordering = ['-id']

    def __unicode__(self):
        return self.username

    def __str__(self):
        return self.username


# 自定义文章管理器
# 1.新加一个数据处理的方法（这里采用）
# 2.改变原有的Queryse方法
class ArticleManager(models.Manager):
    def distinct_date(self):
        distinct_date_list = []
        # 取出日期字段
        date_list = self.values('date_publish')
        for date in date_list:
            # 取出的日期先转换格式
            date = date['date_publish'].strftime('%Y/%m')
            if date not in distinct_date_list:
                distinct_date_list.append(date)
        return distinct_date_list


# 文章模型
class Article(models.Model):
    title = models.CharField(max_length=50, verbose_name='文章标题')
    desc = models.CharField(max_length=50, verbose_name='文章描述')
    content = models.TextField(verbose_name='文章内容')
    click_count = models.IntegerField(default=0, verbose_name='点击次数')
    is_recommend = models.BooleanField(default=False, verbose_name='是否推荐')
    date_publish = models.DateTimeField(auto_now_add=True, verbose_name='发布时间')
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='用户')
    # 外键
    category = models.ForeignKey(Category, on_delete=models.CASCADE, blank=True, null=True, verbose_name='分类')
    # 多对多关系将会自动多生成一张表，blog_article_tag
    tag = models.ManyToManyField(Tag, verbose_name='标签')
    # 在文章模型中加入自定义的管理器
    objects = ArticleManager()

    class Meta:
        verbose_name = '文章'
        verbose_name_plural = verbose_name
        ordering = ['-date_publish']

    def __unicode__(self):
        return self.title

    def __str__(self):
        return self.title


# 自定义评论管理器
# 为了写入原生sql，返回按article分组统计排序的方法
class CommentManager(models.Manager):
    def with_counts(self):
        from django.db import connection
        cursor = connection.cursor()
        cursor.execute("""
			select article_id from blog_comment 
			group by article_id 
			order by count(article_id) 
			desc
		""")
        result_list = []
        # pdb.set_trace()
        # 取出来的是元组类型
        for row in cursor.fetchall():
            id = row[0]
            result_list.append(id)
        return result_list


# 评论模型
class Comment(models.Model):
    content = models.TextField(verbose_name='评论内容')
    username = models.CharField(max_length=30, blank=True, null=True, verbose_name='用户名')
    email = models.EmailField(max_length=50, blank=True, null=True, verbose_name='邮箱地址')
    url = models.URLField(max_length=100, blank=True, null=True, verbose_name='个人网页地址')
    date_publish = models.DateTimeField(auto_now_add=True, verbose_name='发布时间')
    user = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True, verbose_name='用户')
    article = models.ForeignKey(Article, on_delete=models.CASCADE, related_name="entries", blank=True, null=True, verbose_name='文章')
    pid = models.ForeignKey('self', on_delete=models.CASCADE, blank=True, null=True, verbose_name='父级评论')
    # 使用自定义的管理器
    objects = CommentManager()

    class Meta:
        verbose_name = '评论'
        verbose_name_plural = verbose_name
        # 按发布日期倒序排列
        ordering = ['-date_publish']

    def __unicode__(self):
        return self.content

    def __str__(self):
        return self.content


# 友情链接
class Links(models.Model):
    title = models.CharField(max_length=50, verbose_name='标题')
    description = models.CharField(max_length=200, verbose_name='友情链接描述')
    callback_url = models.URLField(verbose_name='url地址')
    date_publish = models.DateTimeField(auto_now_add=True, verbose_name='发布时间')
    index = models.IntegerField(default=999, verbose_name='排列顺序(从小到大)')

    class Meta:
        verbose_name = '友情链接'
        verbose_name_plural = verbose_name
        ordering = ['index', 'id']

    def __unicode__(self):
        return self.title

    def __str__(self):
        return self.title


# 广告
class Ad(models.Model):
    title = models.CharField(max_length=50, verbose_name='广告标题')
    description = models.CharField(max_length=200, verbose_name='广告描述')
    image_url = models.ImageField(upload_to='ad/%Y/%m', verbose_name='图片路径')
    callback_url = models.URLField(null=True, blank=True, verbose_name='回调url')
    date_publish = models.DateTimeField(auto_now_add=True, verbose_name='发布时间')
    index = models.IntegerField(default=999, verbose_name='排列顺序(从小到大)')

    class Meta:
        verbose_name = u'广告'
        verbose_name_plural = verbose_name
        ordering = ['index', 'id']

    def __unicode__(self):
        return self.title

    def __str__(self):
        return self.title
