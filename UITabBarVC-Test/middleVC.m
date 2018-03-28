//
//  middleVC.m
//  UITabBarVC-Test
//
//  Created by qujiahong on 2018/3/26.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "middleVC.h"

@interface middleVC ()

@end

@implementation middleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
