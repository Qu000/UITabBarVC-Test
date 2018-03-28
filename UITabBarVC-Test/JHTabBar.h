//
//  JHTabBar.h
//  UITabBarVC-Test
//
//  Created by qujiahong on 2018/3/26.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

//5、定义枚举
typedef NS_ENUM(NSUInteger, JHItemType) {
    JHItemTypeMiddle,
    JHItemTypeLeft=100,//左边的item[具体意义自定]
    JHItemTypeRight
};

@class JHTabBar;//2

//6
typedef void(^TabBlock)(JHTabBar * tabBar,JHItemType index);

//1、协议
@protocol JHTabBarDelegate <NSObject>

//3、协议方法
- (void)tabBar:(JHTabBar *)tabBar clickBtn:(JHItemType) index;
@end

@interface JHTabBar : UIView

//4、设置代理
@property(nonatomic, weak) id<JHTabBarDelegate> delegate;

//7
@property (nonatomic, copy)TabBlock block;
@end
