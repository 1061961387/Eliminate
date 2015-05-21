//
//  EView.m
//  Eliminate
//
//  Created by 裕福 on 15/5/14.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

#import "EView.h"
#import "EButton.h"

@interface EView()

@property (nonatomic) CGFloat elementWidth;
@property (nonatomic) CGFloat elementHeight;

@property (strong, nonatomic) NSMutableArray *totalArray;
@property (strong, nonatomic) NSMutableArray *removeArray;

@property (nonatomic) NSInteger surplus;
//@property (nonatomic) BOOL isEliminate;

@end

@implementation EView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.row = 10;
        self.column = 10;
        self.margin = 2;
        self.edge = 10;
    }
    return self;
}

- (void)start
{
    self.elementWidth = (self.frame.size.width-(self.column-1)*self.margin-self.edge*2)/self.column;
    self.elementHeight = (self.frame.size.width-(self.row-1)*self.margin-self.edge*2)/self.row;
    NSLog(@"elementWidth = %f -- elementHeight = %f",self.elementWidth,self.elementHeight);
    
    [self initData];
    [self creatBtns];
}

- (void)reload
{
    [self end];
    [self start];
}

- (void)initData
{
    self.totalArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.removeArray = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)creatBtns
{
    for (NSInteger j=0; j<self.column; j++) {
        NSMutableArray *columnArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i=self.row; i>0; i--) {
            EButton *btn = [EButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(self.edge+(self.elementWidth+self.margin)*j, self.edge+(self.elementHeight+self.margin)*(i-1), self.elementWidth, self.elementHeight);
            btn.tag = j*100+self.row-i;
            btn.mTag = btn.tag;
            btn.isExist = YES;
            NSInteger random = arc4random()%5;
            btn.type = random;
//            [btn setTitle:[NSString stringWithFormat:@"%ld",(long)btn.tag] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [columnArray addObject:btn];
        }
        [self.totalArray addObject:columnArray];
    }
}

- (void)click:(EButton *)sender
{
    [self.removeArray removeAllObjects];
    [self.removeArray addObject:sender];
    
    [self addRelateBtn];
    
    if (self.removeArray.count >= 2) {
        for (EButton *btn in self.removeArray) {
            NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.totalArray];
            for (NSMutableArray *array in tmp) {
                if ([array containsObject:btn]) {
                    [array removeObject:btn];
                }
                if (array.count == 0) {
                    [self.totalArray removeObject:array];
                }
            }
            
            [btn removeFromSuperview];
        }
    }else{
        return;
    }
    
    [self updateBtns];
    
    if (![self check]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜您" message:[NSString stringWithFormat:@"获得%ld分",self.column*self.row-self.surplus] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (BOOL)check
{
    [self.removeArray removeAllObjects];
    
//    [self addRelateBtn];
    
    self.surplus = 0;
    for (NSMutableArray *array in self.totalArray) {
        for (EButton *btn in array) {
            [self.removeArray addObject:btn];
            [self addRelateBtn];
            self.surplus ++;
            if (self.removeArray.count >= 2) {
                return YES;
            }else{
                [self.removeArray removeAllObjects];
            }
        }
    }
    return NO;
}

- (void)addRelateBtn
{
    for (int i=0; i<self.removeArray.count; i++) {
        EButton *sender = [self.removeArray objectAtIndex:i];
        NSInteger ten,one = 0;
        NSMutableArray *array = nil;
        for (ten=0; ten<self.totalArray.count; ten++) {
            array = [self.totalArray objectAtIndex:ten];
            if ([array containsObject:sender]) {
                one = [array indexOfObject:sender];
//                NSLog(@"sender.tag = %ld  ten =%ld   one = %ld",(long)sender.tag,(long)ten,(long)one);
                break;
            }
        }
        
        //左
//        NSLog(@"左");
        if (ten>0) {
            NSMutableArray *left = [self.totalArray objectAtIndex:ten-1];
            if (left.count > one) {
                EButton *btn = [left objectAtIndex:one];
                [self compareBtn:sender andAnother:btn];
            }
        }
        
        //上
//        NSLog(@"上");
        if (one<array.count-1) {
            EButton *btn = [array objectAtIndex:one+1];
            [self compareBtn:sender andAnother:btn];
        }
        
        //右
//        NSLog(@"右");
        if (ten<self.totalArray.count-1) {
            NSMutableArray *right = [self.totalArray objectAtIndex:ten+1];
            if (right.count > one) {
                EButton *btn = [right objectAtIndex:one];
                [self compareBtn:sender andAnother:btn];
            }
        }
        
        //下
//        NSLog(@"下");
        if (one>0) {
            EButton *btn = [array objectAtIndex:one-1];
            [self compareBtn:sender andAnother:btn];
        }
    }
}

- (void)compareBtn:(EButton *)sender andAnother:(EButton *)another
{
    if ([self.removeArray containsObject:another]) {
        return;
    }
    if (sender.type == another.type) {
        [self.removeArray addObject:another];
        [self addRelateBtn];
    }
}

- (void)updateBtns
{
    for (NSInteger j=0; j<self.totalArray.count; j++) {
        NSMutableArray *array = [self.totalArray objectAtIndex:j];
        for (NSInteger i=0; i<array.count; i++) {
            EButton *btn = [array objectAtIndex:i];
            [UIView animateWithDuration:0.5 animations:^{
                btn.frame = CGRectMake(self.edge+(self.elementWidth+self.margin)*j, self.edge+(self.elementHeight+self.margin)*(self.row-i-1), self.elementWidth, self.elementHeight);
            }];
        }
    }
}

- (void)end
{
    for (NSMutableArray *array in self.totalArray) {
        for (EButton *btn in array) {
            [btn removeFromSuperview];
        }
    }
    [self.totalArray removeAllObjects];
    self.totalArray = nil;
}

@end
