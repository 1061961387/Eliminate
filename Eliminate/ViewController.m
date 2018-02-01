//
//  ViewController.m
//  Eliminate
//
//  Created by 裕福 on 15/5/14.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

#import "ViewController.h"
#import "EView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCon;
@property (strong, nonatomic) EView *eView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    self.eView = [[EView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
//    self.eView.column = 12;
//    self.eView.row = 12;
//    self.eView.edge = 20;
//    self.eView.margin = 2;
    [self.view addSubview:self.eView];
    [self.eView start];
    
    self.bottomCon.constant = (self.view.frame.size.height - self.view.frame.size.width - 100 -49)/2;
}
- (IBAction)rePlay:(id)sender {
    
    [self.eView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
