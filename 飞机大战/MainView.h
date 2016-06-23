//
//  MainView.h
//  飞机大战
//
//  Created by 张张张小烦 on 16/2/29.
//  Copyright © 2016年 张张张小烦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
{
    UIImage * bulletImage;
    UIImage * enemyImage;
    UIImage * burstImage;
    UIImage * fighterImage;
}


@property (strong,nonatomic) NSMutableArray * bullets;//所有子弹
@property (strong,nonatomic) NSMutableArray * enemys;//所有敌人
@property (strong,nonatomic) NSMutableArray * bursts;//所有爆炸图片
@property (assign,nonatomic) CGPoint fighterPoint;
@end
