# -*- coding:utf-8 -*-
import pdb
from django.shortcuts import render, redirect
import logging
from django.conf import settings
# from django.db.models import Count
from blog.models import *
# 这是django的原生分页类，可以做许多设置
from django.core.paginator import Paginator, \
    InvalidPage, EmptyPage, PageNotAnInteger
# 导入定义的表单类
from blog.forms import *
# django的重量级体现，登录注册直接提供封装好的类
from django.contrib.auth import logout, login, authenticate
from django.contrib.auth.hashers import make_password
from django.http import HttpResponse

# 使用setting.py中配置的日志器，一般都在views.py中使用日志器，因为这里都是业务逻辑
logger = logging.getLogger('blog.views')


# 用setting数据定义全局变量,返回一个字典


def global_setting(request):
    # 用变量装settings的设置,才能通过locals()传过去
    SITE_URL = settings.SITE_URL
    SITE_NAME = settings.SITE_NAME
    SITE_DESC = settings.SITE_DESC
    # 重构一：把类别，广告，归档这些公用内容提出来
    category_list = Category.objects.all()
    ad_list = Ad.objects.all()[:5]
    archive_list = Article.objects.distinct_date()
    article_list = Article.objects.all()
    # 标签云数据
    tag_list = Tag.objects.all()
    # 友情链接数据
    link_list = Links.objects.all()
    # 文章排行榜数据-按点击排序,模板只要求取前6个
    click_article_list = article_list.order_by('-click_count')[:6]
    # 文章排行榜数据-按评论排序
    comment_article_list = []
    result_list = Comment.objects.with_counts()
    # pdb.set_trace()
    for article_id in result_list:
        article = Article.objects.get(id=article_id)
        comment_article_list.append(article)

    # 文章排行榜数据-只选推荐的
    recommend_article_list = Article.objects.filter(is_recommend=True)
    return locals()


# Create your views here.
# 定义首页方法


def index(request):
    try:
        # pdb.set_trace()
        article_list = Article.objects.all()
        article_list = getPage(request, article_list)
    except Exception as e:
        # 如果出现异常就写入日志
        logger.error(e)
    return render(request, 'index.html', locals())


def archive(request):
    try:
        # 先获取客户端提交的信息
        year = request.GET.get('year', None)
        month = request.GET.get('month', None)
        # 同样的文章分页,但是用到filter()做模糊查询
        article_list = Article.objects.filter \
            (date_publish__icontains=year + '-' + month)
        article_list = getPage(article_list)
    except Exception as e:
        logger.error(e)
    return render(request, 'archive.html', locals())


def tag(request):
    try:
        # 先获取客户端提交的标签
        tag = request.GET.get('tag', None)
        # 注意这里tag和article是多对多关系，需要分两步取出标签下的所有文章，要用到_set
        tag = Tag.objects.get(name=tag)
        article_list = tag.article_set.all()
        article_list = getPage(article_list)
    except Exception as e:
        logger.error(e)
    return render(request, 'tag.html', locals())


# 重构分页代码


def getPage(request, article_list):
    # pdb.set_trace()
    paginator = Paginator(article_list, 10)
    try:
        page = int(request.GET.get('page', 1))
        article_list = paginator.page(page)
    except (EmptyPage, InvalidPage, PageNotAnInteger):
        article_list = paginator.page(1)
    return article_list


# 文章详情


def article(request):
    # pdb.set_trace()
    try:
        # 获取文章id
        id = request.GET.get('id', None)
        try:
            # 获取文章信息
            article = Article.objects.get(pk=id)
            article.click_count += 3
            article.save()
        # 注意捕获文章不存在的异常
        except Article.DoesNotExist:
            return render(request, 'failure.html', {'reason': '没有找到对应的文章'})

        # 评论表单
        # 这里初始化了一个评论表单的对象供article.html使用。
        # 这个是用于分别处理登陆情况和未登录情况下默认写入哪些值，提高用户体验
        comment_form = CommentForm({
                                    'author': request.user.username,
                                    'email': request.user.email,
                                    'url': request.user.url,
                                    'article': id} if request.user.is_authenticated else {'article': id})
        # 获取评论信息
        # 注意这个技巧：用一行把文章对应的评论都取出来之后对结果进行归类，只取一次，推荐
        comments = Comment.objects.filter(article=article).order_by('id')
        comment_list = []
        # 实现评论的层级关系
        for comment in comments:
            for item in comment_list:
                if not hasattr(item, 'children_comment'):
                    setattr(item, 'children_comment', [])
                # 如果父级评论非空且和某条评论相 等，那就说明该评论是父评论，加入到子评论列表中
                if comment.pid == item:
                    item.children_comment.append(comment)
                    break
            # 父级评论为空，说明本身就是最顶层的评论
            if comment.pid is None:
                comment_list.append(comment)
        length = len(comment_list)
    except Exception as e:
        print(e)
        logger.error(e)
    return render(request, 'article.html', locals())


# 提交评论
# @csrf_exemp 如果不想进行csrf验证，可以加上这个装饰器，告诉django不需要进行验证
def comment_post(request):
    if not request.user.is_authenticated:
        login_form = LoginForm()
        return render(request, 'login.html', locals())
    try:
        comment_form = CommentForm(request.POST)
        # 先对表单信息进行验证，通过后才获取信息
        if comment_form.is_valid():
            # 获取表单信息
            comment = Comment.objects.create(
                username=comment_form.cleaned_data["author"],
                email=comment_form.cleaned_data["email"],
                url=comment_form.cleaned_data["url"],
                content=comment_form.cleaned_data["comment"],
                article_id=comment_form.cleaned_data["article"],
                # 用django的user类提供的方法来验证是否登录，是就返回用户，否则返回匿名对象
                user=request.user if request.user.is_authenticated else None)
            comment.save()
        else:
            # 没通过就写入error，主要是清除session
            return render(request, 'failure.html',
                          {'reason': comment_form.errors})
    except Exception as e:
        logger.error(e)
        # 注销之后跳转回之前的页面
    return redirect(request.META['HTTP_REFERER'])


# 注销
def do_logout(request):
    try:
        # 直接用django提供的注销功能即可
        logout(request)
    except Exception as e:
        print(e)
        logger.error(e)
    return redirect(request.META['HTTP_REFERER'])


# 注册


def do_reg(request):
    try:
        # 注册一定要以post方式提交
        if request.method == 'POST':
            # 直接使用django的表单类别，否则你还不如去用flask这些轻量级框架
            reg_form = RegForm(request.POST)
            if reg_form.is_valid():
                # 注册
                user = User.objects.create(
                    username=reg_form.cleaned_data["username"],
                    email=reg_form.cleaned_data["email"],
                    url=reg_form.cleaned_data["url"],
                    # 用户明文提交，不过我们是以加密形式保存密码，就用django提供的密码加密方法，这里用它默认的加密方式
                    password=make_password(reg_form.cleaned_data["password"]), )
                user.save()

                # 注册完之后就登录
                user.backend = \
                    'django.contrib.auth.backends.ModelBackend'  # 指定默认的登录验证方式
                # 这个登录方法也是django提供的标准方法
                login(request, user)
                # 登录之后跳转回之前的网页
                return redirect(request.POST.get('source_url'))
            else:
                return render(request, 'failure.html',
                              {'reason': reg_form.errors})
        else:
            reg_form = RegForm()
    except Exception as e:
        logger.error(e)
    return render(request, 'reg.html', locals())


# 登录


def do_login(request):
    try:
        if request.method == 'POST':
            login_form = LoginForm(request.POST)
            if login_form.is_valid():
                # 登录
                username = login_form.cleaned_data["username"]
                password = login_form.cleaned_data["password"]
                # 使用django提供的验证方法，传入用户名和密码，会返回一个user对象。这个方法我们也可以重写
                user = authenticate(username=username, password=password)
                # 如果用户存在，那就通过登录验证，和注册一样
                if user is not None:
                    user.backend = \
                        'django.contrib.auth.backends.ModelBackend'  # 指定默认的登录验证方式
                    login(request, user)
                # 否则就跳转到登录失败
                else:
                    return render(request, 'failure.html',
                                  {'reason': '登录验证失败'})
                return redirect(request.POST.get('source_url'))
            else:
                return render(request, 'failure.html', {'reason': login_form.errors})
        # 如果不是post提交就跳转到登录页面
        else:
            login_form = LoginForm()
    except Exception as e:
        logger.error(e)
    return render(request, 'login.html', locals())


# 分类


def category(request):
    try:
        # 先获取客户端提交的信息
        cid = request.GET.get('cid', None)
        try:
            category = Category.objects.get(pk=cid)
        except Category.DoesNotExist:
            return render(request, 'failure.html', {'reason': '分类不存在'})
        article_list = Article.objects.filter(category=category)
        article_list = getPage(request, article_list)
    except Exception as e:
        logger.error(e)
    return render(request, 'category.html', locals())


def search(request):
    print("****************")
    search_content = request.POST.get("search")
    try:
        # pdb.set_trace()
        article_list = Article.objects.filter(title__icontains=search_content)
        article_list = getPage(request, article_list)
    except Exception as e:
        logger.error(e)
    return render(request, 'index.html', locals())