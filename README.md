# FlappyBird
simplest flappy bird(based on objective-c)

HI 爽哥，
有几个问题解决不了啊。。。求指导；

1. 现在的label/button/imview...都是固定大小，即使我在storyboard里居了中，放到iPhone simulator上还是truncated的，有没有一种方法能让这些控件大小自适应？

2. 不知道啥时候空间刷新还是怎么的，有两个问题很相似，现在在code中是注释掉的部分。
   1 换鸟问题：
	本来想整成鸟速度向上用bird-up.png, 鸟速度向下用bird-down.png,结果一换鸟，新鸟就直接从貌似整个view的center的地方开始掉；（见birdMoving函数）
   2 计分问题：
	GameViewController.m的TunnelMoving函数里调用的IncScore函数，想说鸟飞过一对柱子就给score+1，score+1是没问题，但是更新那个label_score.text之后柱子直接从中间出来了（按理说应该执行PlaceTunnels函数，从最右边出来的），所以这句话注释掉了。。。但是不知道为啥会这么诡异
