//
//  EView.h
//  Eliminate
//
//  Created by 裕福 on 15/5/14.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EView : UIView

@property (nonatomic) NSInteger row;//行
@property (nonatomic) NSInteger column;//列
@property (nonatomic) CGFloat margin;//间距
@property (nonatomic) CGFloat edge;//边距

- (void)start;

- (void)reload;

@end
