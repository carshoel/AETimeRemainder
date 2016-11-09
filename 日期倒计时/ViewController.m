//
//  ViewController.m
//  日期倒计时
//
//  Created by carshoel on 16/11/5.
//  Copyright © 2016年 carshoel. All rights reserved.
//

#import "ViewController.h"
#import "TimeRemainderView.h"

@interface ViewController ()<TimeRemainderViewDelegate>

@property (nonatomic, weak)TimeRemainderView *remainder;

@property (nonatomic, weak)UILabel *endTestShowL;

@end

@implementation ViewController

-(UILabel *)endTestShowL{
    if(!_endTestShowL){
        CGFloat x = 10;
        CGFloat w = CGRectGetWidth(self.remainder.frame) - 2 * x;
        CGFloat h = 80;
        CGFloat y = CGRectGetHeight(self.remainder.frame) - h - 20;
        UILabel *endTestShowL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        endTestShowL.backgroundColor = [UIColor whiteColor];
        endTestShowL.numberOfLines = 0;
        endTestShowL.font = [UIFont systemFontOfSize:15];
        endTestShowL.textAlignment = NSTextAlignmentCenter;
        _endTestShowL = endTestShowL;
        [self.remainder addSubview:endTestShowL];
    }
    return _endTestShowL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 设置控制器view背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2 设置倒计时控件
    [self setUpRemainderView];
    
    //3 设置操作面板
    [self setUpOperationView];
}

//设置倒计时控件
- (void)setUpRemainderView{
    CGFloat w = 200;
    CGFloat h = w;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - w) * 0.5;
    CGFloat y = 50;
    TimeRemainderView *remainder = [[TimeRemainderView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    remainder.backgroundColor = [UIColor orangeColor];
    remainder.date = [NSDate dateWithTimeIntervalSinceNow:60 * 30 + 5];
    remainder.delegate = self;
    remainder.titleStr = @"距离高考还有";
    self.remainder = remainder;
    [self.view addSubview:remainder];
}

//设置操作面板
- (void)setUpOperationView{
    CGFloat w = 220;
    CGFloat h = 30;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - w) * 0.5;
    CGFloat y = CGRectGetMaxY(self.remainder.frame) + 20;
    
    UIButton *yearBtn = [self btnWithTitle:@"时间超过一年 ＋1 秒效果" frame:CGRectMake(x, y, w, h) action:@selector(yearBtnClick)];
    [self.view addSubview:yearBtn];
    
    y = CGRectGetMaxY(yearBtn.frame) + 25;
    UIButton *dayBtn = [self btnWithTitle:@"时间超过一天 ＋1 秒效果" frame:CGRectMake(x, y, w, h) action:@selector(dayBtnClick)];
    [self.view addSubview:dayBtn];
    
    y = CGRectGetMaxY(dayBtn.frame) + 25;
    UIButton *hourBtn = [self btnWithTitle:@"时间大于一个小时 ＋1 秒效果" frame:CGRectMake(x, y, w, h) action:@selector(hourBtnClick)];
    [self.view addSubview:hourBtn];
    
    y = CGRectGetMaxY(hourBtn.frame) + 25;
    UIButton *secondBtn = [self btnWithTitle:@"进入最后5秒" frame:CGRectMake(x, y, w, h) action:@selector(secondBtnClick)];
    [self.view addSubview:secondBtn];
    
    y = CGRectGetMaxY(secondBtn.frame) + 25;
    UIButton *halfHourBtn = [self btnWithTitle:@"半小时＋2 秒效果" frame:CGRectMake(x, y, w, h) action:@selector(halfHourBtnClick)];
    [self.view addSubview:halfHourBtn];

    
}
//创建一个按钮
- (UIButton *)btnWithTitle:(NSString *)title frame:(CGRect)frame action:(SEL)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.masksToBounds = YES;
    
    return btn;
}

//年
- (void)yearBtnClick{
    [_endTestShowL removeFromSuperview];
    self.remainder.date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 + 1];
}

//天
- (void)dayBtnClick{
    [_endTestShowL removeFromSuperview];
    self.remainder.date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 + 1];
}

//小时
- (void)hourBtnClick{
    [_endTestShowL removeFromSuperview];
    self.remainder.date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 + 1];
}

//分秒
- (void)secondBtnClick{
    [_endTestShowL removeFromSuperview];
    self.remainder.date = [NSDate dateWithTimeIntervalSinceNow:5];
}

//半小时2秒
- (void)halfHourBtnClick{
    [_endTestShowL removeFromSuperview];
    self.remainder.date = [NSDate dateWithTimeIntervalSinceNow:60 * 30 + 3];
}

#pragma mark - 代理
- (void)remainderViewTimeEnd:(TimeRemainderView *)remainderView{
    
    //测试显示
    self.endTestShowL.text = @"倒计时完毕会掉用代理方法:remainderViewTimeEnd";
}

- (void)remainderViewTimeEndBgein:(TimeRemainderView *)remainderView{
    
    //测试显示
    self.endTestShowL.text = @"倒计时小于半小时会掉用一次该代理方法:remainderViewTimeEndBgein";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
