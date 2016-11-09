//
//  NSString+GetSize.m
//  size
//
//  Created by carshoel on 16/1/2.
//  Copyright (c) 2016年 carshoel. All rights reserved.
//

#import "NSString+GetSize.h"

@implementation NSString (GetSize)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{

    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = font;
    att[NSForegroundColorAttributeName] = [UIColor blackColor];
//    return [self sizeWithAttributes:att];
    
     return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:att context:nil].size;
    
}
@end
