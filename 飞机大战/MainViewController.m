//
//  MainViewController.m
//  飞机大战
//
//  Created by 张张张小烦 on 16/2/29.
//  Copyright © 2016年 张张张小烦. All rights reserved.
//

#import "MainViewController.h"
#import "ZHYKSprite.h"

#define SCREEN [UIScreen mainScreen].bounds.size
@interface MainViewController ()



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    drawView = [[MainView alloc]init];
    self.view = drawView;
    // 构建定时器
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
}
//实现定时器行为
-(void)onTimer:(NSTimer *) sender {
    //调整每个子弹的坐标
    //遍历每个子弹对象
    for (ZHYKSprite * s in drawView.bullets) {
        //
        s.y-=5;
        //判定子弹是否已经超出屏幕
        if (s.y<0) {
            //把子弹设定为无效
            s.isUsed=NO;
        }
    }
    //创建一个静态计数器 用来控制敌人产生的速度
    static int c=0;
    c++;
    if (c==6) {
        //随机产生敌人
        //随机产生一个x坐标
        int x = arc4random()%340;
        //构建敌人对象
        ZHYKSprite * enemy = [[ZHYKSprite alloc]init];
        //设定敌人的x坐标
        enemy.x = x;
        //设定敌人的 y 坐标，向上移动
        enemy.y = 10;
        //标示当前敌人为有效敌人
        enemy.isUsed = YES;
        //把敌人对象放到当前视图的敌人集合中
        [drawView.enemys addObject:enemy];
        //计数器清零，重新计数
        c=0;
    }
    //碰撞检测  看子弹和敌人两个图片矩形区域是否有相交
    //遍历当前子弹的对象
    for (ZHYKSprite * bullet in drawView.bullets) {
        //得到当前子弹的矩形范围
        CGRect bulletRect = CGRectMake(bullet.x, bullet.y, 15, 15);
        
        //遍历当前敌人
        for (ZHYKSprite * enemy in drawView.enemys) {
            //得到当前敌人的矩形范围
            CGRect enemyRect = CGRectMake(enemy.x, enemy.y, 30, 30);
            //如果两个对象有相交
            if (CGRectIntersectsRect(bulletRect, enemyRect)) {
                //两者都消失
                bullet.isUsed=NO;
                enemy.isUsed=NO;
                
                //产生爆炸效果
                //构建爆炸对象
                ZHYKSprite * burst = [[ZHYKSprite alloc]init];
                //设定爆炸坐标
                burst.x = enemy.x;
                burst.y = enemy.y;
                //设定为有效爆炸
                burst.isUsed = YES;
                //把这个爆炸对象加到爆炸集合中
                [drawView.bursts addObject:burst];
            }
        }
    }
    //调整每个敌人的坐标
    //遍历每个敌人对象
    for (ZHYKSprite * s in drawView.enemys) {
        //
        s.y+=5;
        //判定敌人是否已经超出屏幕
        if (s.y>self.view.frame.size.height) {
            //把敌人设定为无效
            s.isUsed=NO;
        }
    }
    //刷新屏幕
    [self.view setNeedsDisplay];
}
//触摸开始
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //先获得触摸对象
    UITouch * touch = [touches anyObject];
    //获得触摸点的坐标
    CGPoint p = [touch locationInView:self.view];
    
    //战斗机显示位置
    //self.fighterPoint = CGPointMake(SCREEN.width/2-62/2, SCREEN.height-20-74);
    
    //在这个点显示战斗机
    drawView.fighterPoint = p;
    //判定点击区域y坐标是否在规定区域
    if (p.y>350) {
        //构建子弹对象
        ZHYKSprite * bullte = [[ZHYKSprite alloc]init];
        //设定子弹的x坐标
        bullte.x = p.x+62/2-6;
        //设定子弹的 y 坐标
        bullte.y = p.y-10;
        //标示当前子弹为有效子弹
        bullte.isUsed = YES;
        //把子弹对象放到当前视图的子弹集合中
        [drawView.bullets addObject:bullte];
    }
    //重新绘制当前视图
    [self.view setNeedsDisplay];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
