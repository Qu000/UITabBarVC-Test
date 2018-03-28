//
//  JHTabBar.m
//  UITabBarVC-Test
//
//  Created by qujiahong on 2018/3/26.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "JHTabBar.h"

@interface JHTabBar()
/** item数据源 */
@property (nonatomic, strong)NSArray * itemsList;

/** 上一次点击的item */
@property (nonatomic, strong) UIButton * lastItem;

/** 中间的特殊item */
@property (nonatomic, strong) UIButton * midButton;
@end

@implementation JHTabBar

-(NSArray *)itemsList{
    if (!_itemsList) {
        _itemsList = @[@"tab_left",@"tab_right"];
    }
    return _itemsList;
}
-(UIButton *)midButton{
    if (!_midButton) {
        _midButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_midButton setImage:[UIImage imageNamed:@"tab_middle"] forState:UIControlStateNormal];
        _midButton.tag = JHItemTypeMiddle;
        [_midButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _midButton;
}

//view中、控件初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (NSInteger i=0; i<self.itemsList.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            [item setImage:[UIImage imageNamed:self.itemsList[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.itemsList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = JHItemTypeLeft + i;
            //图片取消高亮
            item.adjustsImageWhenHighlighted = NO;
            
            if (i==0) {
                item.selected = YES;
                self.lastItem = item;
            }
           
            [self addSubview:item];
            
        }
        //添加中间的特殊按钮
        [self addSubview:self.midButton];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width / self.itemsList.count;
    
    for (NSInteger i=0; i< [self subviews].count; i++) {
        UIView * btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = CGRectMake((btn.tag - JHItemTypeLeft)*w, 0, w, self.frame.size.height);
        }
    }
    [self.midButton sizeToFit];
    self.midButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-40);
}

- (void)clickItem:(UIButton *)button{
    //判断代理是否能响应某个方法
    if ([self.delegate respondsToSelector:@selector(tabBar:clickBtn:)]) {
        [self.delegate tabBar:self clickBtn:button.tag];
    }
    
    //走block
    //!self.block?:self.block(self,button.tag)
    if (self.block) {
        self.block(self, button.tag);
    }
    
    //取消中间button的动画&&不影响其他两个按钮
    if (button.tag == JHItemTypeMiddle) {
        return;
    }
    
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    //设置动画
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);//先扩大到1.2
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformIdentity;//恢复
        }];
    }];
}






@end
