//
//  TimeRemainderView.m
//  DLZhiYuanMao
//
//  Created by carshoel on 16/10/4.
//  Copyright © 2016年 carshoel. All rights reserved.
//

#import "TimeRemainderView.h"
#import "NSString+GetSize.h"

#define k1Font [UIFont systemFontOfSize:15]
#define kAppColor [UIColor redColor]

@interface TimeRemainderView ()
{
    UILabel *labelOne;
    UILabel *labelOneUnite;
    UILabel *labelTwo;
    UILabel *labelTwoUnite;

}

@property (nonatomic, weak)UILabel *titleL;
@property (nonatomic, weak)UIView *endTimeView;

@property (nonatomic, assign)int statu;//1 年倒计时 2 天的倒计时 3 小时de倒计时 4 秒的倒计时



@end

@implementation TimeRemainderView


-(UILabel *)titleL{
    if(!_titleL){
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
        titleL.font = [UIFont boldSystemFontOfSize:18];
        titleL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleL];
        _titleL = titleL;
        _titleL.text = @"距离会议开始还有";
    }
    return _titleL;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleL.text = titleStr;
}

-(UIView *)endTimeView{

    if(!_endTimeView){
        UIView *endV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleL.frame), self.bounds.size.width, 44)];
        [self addSubview:endV];
        
        UILabel *l1 = [[UILabel alloc] init];
        l1.textAlignment = NSTextAlignmentCenter;
        l1.textColor = [UIColor whiteColor];
        l1.backgroundColor = kAppColor;
        l1.font = k1Font;
        labelOne = l1;
        [endV addSubview:l1];
        
        UILabel *l1u = [[UILabel alloc] init];
        l1u.textAlignment = NSTextAlignmentCenter;
        l1u.textColor = [UIColor whiteColor];
        l1u.backgroundColor = kAppColor;
        l1u.font = k1Font;
        labelOneUnite = l1u;
        [endV addSubview:l1u];
        
        UILabel *l2 = [[UILabel alloc] init];
        l2.textAlignment = NSTextAlignmentCenter;
        l2.textColor = [UIColor whiteColor];
        l2.backgroundColor = kAppColor;
        l2.font = k1Font;
        labelTwo = l2;
        [endV addSubview:l2];
        
        UILabel *l2u = [[UILabel alloc] init];
        l2u.textAlignment = NSTextAlignmentCenter;
        l2u.textColor = [UIColor whiteColor];
        l2u.backgroundColor = kAppColor;
        l2u.font = k1Font;
        labelTwoUnite = l2u;
        [endV addSubview:l2u];
        
        _endTimeView = endV;
        
    }
    return _endTimeView;
}

//根据array 重新布局endView内部的控件
- (void)upFrameForEndViewWithArray:(NSArray *)array{
    
    if(!array || array.count < 3)return;
    CGRect frame = self.endTimeView.frame;
    
    NSNumber *statu = array.firstObject;
    if(statu.intValue == 1){// xx年xx天
        labelOneUnite.text = @"年";
        labelTwoUnite.text = @"天";
    }
    if(statu.intValue == 2){// xx天xx小时
        labelOneUnite.text = @"天";
        labelTwoUnite.text = @"小时";
    }
    if(statu.intValue == 3){// xx小时xx分
        labelOneUnite.text = @"小时";
        labelTwoUnite.text = @"分";
    }
    if(statu.intValue == 4){// xx分xx秒
        labelOneUnite.text = @"分";
        labelTwoUnite.text = @"秒";
    }
    
    NSNumber *n = array[1];
    NSString *str1 = [NSString stringWithFormat:@"%ld",n.longValue];
    n = array[2];
    NSString *str2 = [NSString stringWithFormat:@"%ld",n.longValue];
    
    CGFloat w1 = [str1 sizeWithFont:labelOne.font maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
    if(w1 < 44)w1 = 44;
    CGFloat w2 = [str2 sizeWithFont:labelTwo.font maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
    if(w2 < 44)w2 = 44;
    labelOne.text = str1;
    labelTwo.text = str2;
    
    CGFloat x = 0;
    CGFloat w = w1;
    CGFloat h = 44;
    labelOne.frame = CGRectMake(x, 0, w, h);
    
    x = CGRectGetMaxX(labelOne.frame) + 10;
    w = 40;
    labelOneUnite.frame = CGRectMake(x, 0, w, h);
    
    x = CGRectGetMaxX(labelOneUnite.frame) + 10;
    w = w2;
    labelTwo.frame = CGRectMake(x, 0, w, h);
    
    x = CGRectGetMaxX(labelTwo.frame) + 10;
    w = 40;
    labelTwoUnite.frame = CGRectMake(x, 0, w, h);
    
    frame.size.width = CGRectGetMaxX(labelTwoUnite.frame);
    frame.origin.x = (self.frame.size.width - frame.size.width) * 0.5;
    self.endTimeView.frame = frame;
    
}

-(void)setDate:(NSDate *)date{
    _date = date;
    [self setUpEndTimeShow];
}


//计算时间 转为秒数
- (NSInteger)endTimeWithDate:(NSDate *)date{

    NSTimeInterval l = [date timeIntervalSinceNow];
    
    // l 转 秒 这里计算
    
    return l;
}

//计算显示的结果方式
- (void)setUpEndTimeShow{
    
    NSInteger l = [self endTimeWithDate:self.date];
    
    
    
    NSInteger yearS = 365 * 24 * 60 * 60;
    NSInteger dayS = 24 * 60 * 60;
    NSInteger hourS = 60  * 60;
    
    //大于等于365天  显示年 天
    if(l >= yearS){
    
        NSInteger yearD = l / yearS;
        NSInteger day = (l  - (yearD * yearS)) / dayS;
       
        if(day == 0){
            NSLog(@"%ld年",yearD);
        }else{
            NSLog(@"%ld年%ld天",yearD,day);
        }
        
        [self upFrameForEndViewWithArray:@[@1,@(yearD),@(day)]];
        
        if(self.statu != 1){
            self.statu = 1;
            [self makeTimeWithInterval:dayS];
        }
        
    }
    
    //大于天  显示天
    if(l < yearS && l >= dayS){
        NSInteger day = l / dayS;
        NSInteger hour = (l - day * dayS) / hourS;
//        NSLog(@"%ld天,%ld小时",day,hour);
        [self upFrameForEndViewWithArray:@[@2,@(day),@(hour)]];
        if(self.statu != 2){
            self.statu = 2;
            [self makeTimeWithInterval:hourS];
        }
    }
    
    //大于一个小时
    if(l < dayS && l >= hourS){
        
        NSInteger hour = l / hourS;

        NSInteger sencend = (l - hourS * hour) / 60;
        
//        NSLog(@"%ld小时%ld分钟",hour,sencend);
        [self upFrameForEndViewWithArray:@[@3,@(hour),@(sencend)]];
        if(self.statu != 3){
            self.statu = 3;
            [self makeTimeWithInterval:60];
        }
    }
    
    
    //小于一个小时
    if(l < hourS && l > 0){
        NSInteger secend = l / 60;
        NSInteger s = (l - secend * 60);
        if(secend <= 29){
//            self.titleL.text = @"会议倒计时";
            if([self.delegate respondsToSelector:@selector(remainderViewTimeEndBgein:)]){
                [self.delegate remainderViewTimeEndBgein:self];
            }
        }
//        NSLog(@"xxx%ld分钟%ld秒",secend,s);
        [self upFrameForEndViewWithArray:@[@4,@(secend),@(s)]];
        
        if(secend == 0){
            
        }
        //如果时秒为单位
        if(self.statu != 4){
            self.statu = 4;
            [self makeTimeWithInterval:1];
        }
        
    }
    
    
    if(l <= 0){

//        self.titleL.text = @"会议已经开始,请签到";
        [self upFrameForEndViewWithArray:@[@4,@(0),@(0)]];
        [self.timer invalidate];
        self.timer = nil;
        
        if([self.delegate respondsToSelector:@selector(remainderViewTimeEnd:)]){
            [self.delegate remainderViewTimeEnd:self];
        }
    }
    
}

//创建定时器
- (void)makeTimeWithInterval:(NSTimeInterval)ti{

    //移除旧的定时器
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    
    //注：为了减少逻辑判断及时更新UI 这里暂拦截 ti 的值 设置为1秒更新  如有需要优化性能的同学可在注释此行代码 并在setUpEndTimeShow方法里增加判断
    ti = 1.0;
    
    //创建新的
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(setUpEndTimeShow) userInfo:nil repeats:YES];
    _timer = timer;
    [timer fire];
    
}


-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

@end
