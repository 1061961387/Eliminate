//
//  EButton.h
//  Eliminate
//
//  Created by 裕福 on 15/5/14.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EBUTTONCOLOR) {
    EBUTTONCOLOR_RED,
    EBUTTONCOLOR_YELLOW,
    EBUTTONCOLOR_BLUE,
    EBUTTONCOLOR_GREEN,
    EBUTTONCOLOR_PURPLE
};

@interface EButton : UIButton

@property (nonatomic) NSInteger clickCount;
@property (nonatomic) EBUTTONCOLOR type;
@property (nonatomic) NSInteger mTag;
@property (nonatomic) BOOL isExist;

@end
