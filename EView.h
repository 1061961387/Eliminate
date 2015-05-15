//
//  EView.h
//  Eliminate
//
//  Created by 裕福 on 15/5/14.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EView : UIView

IB_DESIGNABLE

@property (nonatomic) IBInspectable NSInteger row;
@property (nonatomic) IBInspectable NSInteger column;
@property (nonatomic) CGFloat margin;
@property (nonatomic) CGFloat edge;

- (void)start;

- (void)reload;

@end
