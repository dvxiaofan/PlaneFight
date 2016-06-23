//
//  MainView.m
//  飞机大战
//
//  Created by 张张张小烦 on 16/2/29.
//  Copyright © 2016年 张张张小烦. All rights reserved.
//

#import "MainView.h"
#import "ZHYKSprite.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@implementation MainView
-(instancetype)initWithFrame:(CGRect)frame {
    self = ([super initWithFrame:frame]);
    if (self) {
        self.backgroundColor=[UIColor grayColor];
        //战斗机显示位置
        self.fighterPoint = CGPointMake(SCREEN.width/2-62/2, SCREEN.height-20-74);
        //加载子弹图片
        bulletImage = [UIImage imageNamed:@"zd"];
        //构建保存所有子弹对象的数组集合
        self.bullets = [[NSMutableArray alloc] initWithCapacity:100];
        //加载敌人图片
        enemyImage = [UIImage imageNamed:@"dr"];
        //构建保存所有敌人对象的集合
        self.enemys = [[NSMutableArray alloc] initWithCapacity:100];
        //加载爆炸图片
        burstImage = [UIImage imageNamed:@"bz"];
        //构建保存所有爆炸对象的集合
        self.bursts = [[NSMutableArray alloc]initWithCapacity:100];
        //加载战斗机图片
        fighterImage = [UIImage imageNamed:@"nc"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //绘制战斗机
    [fighterImage drawAtPoint:self.fighterPoint];
    //构建保存要移除无效数据的集合
    NSMutableArray * failArray = [[NSMutableArray alloc]initWithCapacity:100];
    /* 处理子弹 */
    //遍历子弹集合
    for (ZHYKSprite * bb in self.bullets) {
        //在坐标点位绘制子弹
        [bulletImage drawAtPoint:CGPointMake(bb.x, bb.y)];
    }
    //清空无效数据集合
    [failArray removeAllObjects];
    //遍历子弹集合中无效子弹
    for (ZHYKSprite * s in self.bullets) {
        //如果子弹无效
        if (s.isUsed==NO) {
            //放进要移除的子弹集合
            [failArray addObject:s];
        }
    }
    //真正的移除无效子弹
    [self.bullets removeObjectsInArray:failArray];
    
    /* 处理敌人 */
    //遍历敌人集合中的敌人
    for (ZHYKSprite * ee in self.enemys) {
        //按照坐标绘制每一个敌人
        [enemyImage drawAtPoint:CGPointMake(ee.x, ee.y)];
    }
    //先清空无效数组集合
    [failArray removeAllObjects];
    //遍历每个敌人
    for (ZHYKSprite * ee in self.enemys) {
        //如果敌人无效了
        if (ee.isUsed==NO) {
            //放进要移除的敌人集合
            [failArray addObject:ee];
        }
    }
    //真正的移除无效敌人
    [self.enemys removeObjectsInArray:failArray];
    /* 处理爆炸 */
    //遍历爆炸
    for (ZHYKSprite * bz in self.bursts) {
        //绘制每一个爆炸
        [burstImage drawAtPoint:CGPointMake(bz.x, bz.y)];
        //爆炸后让爆炸失效
        bz.isUsed = NO;
    }
    //先清空无效数据集合
    [failArray removeAllObjects];
    //遍历每个爆炸
    for (ZHYKSprite * bz in self.bursts) {
        //如果爆炸无效
        if (bz.isUsed==NO) {
            //放进要移除的爆炸集合
            [failArray addObject:bz];
        }
    }
    //真正移除无效的爆炸对象
    [self.bursts removeObjectsInArray:failArray];
}
@end
