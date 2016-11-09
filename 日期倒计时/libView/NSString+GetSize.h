//
//  NSString+GetSize.h
//  size
//
//  Created by carshoel on 16/1/2.
//  Copyright (c) 2016年 carshoel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (GetSize)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
