# MyAllSwiftDemos

swift写的所有可以复用的demos

有bug的，有建议的，有优化的。欢迎提出，发送wkffantasy@foxmail.com。一起交流学习。

可以复用的Views

1.跑马灯的效果

用frame的方式来创建 用法在MarqueeController这个控制器里面

2.可以复用的tabsSelectView

用的SnapKit进行的布局，支持图片 和 文字。很普通的一个view

3.可以复用的一个可以无限滚动的scrollView

用的frame进行布局，pageControl需要自己定制(定制的方法在NoMarginScrollController里面)。注意：需要在controller销毁的时候，把这个view的定时器给消除，调用removeTimer()方法。

4.AVPlayer写的一个视频播放器

用的SnapKit写的布局。纯swift写的。这个播放器可以横屏 小屏，快进，快退，左上滑改亮度，右上滑改声音。待完善。a.和controller的耦合性比较高。b.当上下滑动改变亮度和声音的时候 需要加一个view来显示。c.一旦播放就要去下载这个视频，等下次播放的时候直接播放本地的。d.没有加网络判断。

5.一个转盘

加了一个pan的手势，可以让圆跟着pan来滑动。每一个item和item的分割线也跟着滑动。a.有一个体验不好的地方就是在y轴上pan的手势滑动效果不明显。b.item只能是垂直向下。我在想想。哎。感觉不好整。但是挺好玩的。


有兴趣做的小动画，很简单的小动画

1.弧形的动画

tableView上下滑动的时候带动弧形动画，这个弧形可以用自动布局，也可用frame，不过个人比较喜欢自动布局
喜欢这个框架SnapKit

2.wave

看到这个效果不错，于是乎看了别人写的之后，自己也学了点知识。

3.

4.和iTunes有关

突然想到的,可以连接电脑，在iTunes里面看到app的某些文件，可以拖文件到app，可以侧滑删除文件

5.天女散花

看到一个oc写的一个发射器，感觉这个发射器的类很厉害。感觉 挺好玩


其他的

1.下载的tool

目前，还不支持后台下载，目前支持断点下载，显示下载速度，下载的剩余时间，下载的进度

2.浅学FMDB

刚刚学了一点，简单的操作，目前还没有主键和Data类型的例子

3.scrollManyTabViews

以前项目有用到的，一直想自己写一个

其余的
1，引入了一些字体，可以随时引入。只不过下载最难找。同样的方法，可以使用React Native。

2，有3Dtouch 效果。长安app。会出现

