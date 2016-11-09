//
//  TimeRemainderView.h
//  DLZhiYuanMao
//
//  Created by carshoel on 16/10/4.
//  Copyright © 2016年 carshoel. All rights reserved.
//  会议时间倒计时

#import <UIKit/UIKit.h>
@class TimeRemainderView;
@protocol TimeRemainderViewDelegate <NSObject>

@optional
/**刚进入最后半小时会掉用这个方法*/
- (void)remainderViewTimeEndBgein:(TimeRemainderView *)remainderView;
/**倒计时结束会掉用这个方法*/
- (void)remainderViewTimeEnd:(TimeRemainderView *)remainderView;
@end

@interface TimeRemainderView : UIView

@property (nonatomic, strong)NSString *titleStr;//标题
@property (nonatomic, strong)NSDate *date;//倒计时预定时间
@property (nonatomic, weak)NSTimer *timer;
@property (nonatomic, weak)id<TimeRemainderViewDelegate> delegate;

@end
