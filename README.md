---
title: 运用Django和MySQL搭建本地个人博客主页
---

### 效果图如下:

![这里写图片描述](http://img.blog.csdn.net/20161104164540811)

### 注意: 代码存在github中,连接是:    https://github.com/Mrzhangjwei/blog_project


 里面有一个blogdb.sql文件,是存放数据库和你所用到的各种数据,如果你向在自己电脑上运行成功的话,应该做一下一下几步:
 
-  在任意目录下输入命令:` mysql -u root -p<[备份文件的保存路径]`,当然在我这个项目里,我的数据库用户名为root.

- 进入到文件目录为blog_project/blog_project/settings.py的文件中,修改两个地方,如下图:

![这里写图片描述](http://img.blog.csdn.net/20161104165257275)

 把上面这个图片中这个文件中的'USER'改成你自己的数据库用户名,对应的数据库密码:'PASSWORD'改成你自己数据库的密码.

![这里写图片描述](http://img.blog.csdn.net/20161104164917251)

 把上图中SITE_URL改成你自己的本机地址.然后你在访问的时候九输入你的本机地址就可以了.

#### 如果出现`ImportError: No module named pymysql`这个提示错误,解决方法如图:

![这里写图片描述](http://img.blog.csdn.net/20161104165725286)

 其实就是用`sudo pip install pymysql`这个指令解决的

 最后你输入`python manage.py runserver`然后访问你的本机地址加端口号就能出现个人博客主页的界面了.
