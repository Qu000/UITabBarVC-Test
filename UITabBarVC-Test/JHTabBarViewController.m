//
//  JHTabBarViewController.m
//  UITabBarVC-Test
//
//  Created by qujiahong on 2018/3/26.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "JHTabBarViewController.h"
#import "JHTabBar.h"
#import "JHNavigationController.h"
#import "middleVC.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface JHTabBarViewController ()<JHTabBarDelegate>

@property (nonatomic, strong)JHTabBar * jhTabBar;

@end

@implementation JHTabBarViewController

-(JHTabBar *)jhTabBar{
    if (!_jhTabBar) {
        _jhTabBar = [[JHTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _jhTabBar.delegate = self;
    }
    return _jhTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载控制器
    [self setupChildrenViewController];
    
    // 加载tabBar
    [self.tabBar addSubview:self.jhTabBar];
    //去掉tabBar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

- (void)setupChildrenViewController{
    NSMutableArray * childArr = [NSMutableArray arrayWithArray:@[@"leftVC",@"rightVC"]];
    for (NSInteger i=0; i<childArr.count; i++) {
        NSString *vcName = childArr[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        
        JHNavigationController * nav = [[JHNavigationController alloc]initWithRootViewController:vc];
        [childArr replaceObjectAtIndex:i withObject:nav];
        
    }
    self.viewControllers = childArr;
}
#pragma mark ---- 实现JHTabBarDelegate方法
-(void)tabBar:(JHTabBar *)tabBar clickBtn:(JHItemType)index{
    //不是特殊视图时
    if (index != JHItemTypeMiddle) {
        self.selectedIndex = index - JHItemTypeLeft;
        return;
    }
    
    //是模态视图
    middleVC * midVc = [[middleVC alloc]init];
    [self presentViewController:midVc animated:YES completion:nil];
    
    
}

@end
