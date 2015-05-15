//
//  EButton.m
//  Eliminate
//
//  Created by 裕福 on 15/5/14.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

#import "EButton.h"

@implementation EButton

- (void)setType:(EBUTTONCOLOR)type
{
    if (type == EBUTTONCOLOR_RED) {
        [self setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        _type = EBUTTONCOLOR_RED;
    }else if (type == EBUTTONCOLOR_YELLOW) {
        [self setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateNormal];
        _type = EBUTTONCOLOR_YELLOW;
    }else if (type == EBUTTONCOLOR_BLUE) {
        [self setBackgroundImage:[self imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        _type = EBUTTONCOLOR_BLUE;
    }else if (type == EBUTTONCOLOR_GREEN) {
        [self setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
        _type = EBUTTONCOLOR_GREEN;
    }else{
        [self setBackgroundImage:[self imageWithColor:[UIColor purpleColor]] forState:UIControlStateNormal];
        _type = EBUTTONCOLOR_PURPLE;
    }
}

-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
