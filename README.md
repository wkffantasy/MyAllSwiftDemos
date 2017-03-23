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
