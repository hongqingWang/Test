//
//  HQSliderView.m
//  Unicare
//
//  Created by 王红庆 on 16/10/9.
//  Copyright © 2016年 王红庆. All rights reserved.
//

#import "HQSliderView.h"

@interface HQSliderView ()

/** 标题数组 */
@property (nonatomic, strong) NSArray *titleArray;
/** 滑块 */
@property (nonatomic, weak) UIView *sliderView;
/** 滑块宽度 */
@property (nonatomic, assign) CGFloat sliderWidth;
/** 临时按钮(用来记录哪个按钮为选中状态) */
@property (nonatomic, weak) UIButton *tempBtn;

@end

@implementation HQSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = kScreenWidth;
        CGFloat h = 44;
        self.frame = CGRectMake(x, y, w, h);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat y = 0;
    CGFloat w = kScreenWidth / self.titleArray.count;
    CGFloat h = self.h;
    
    self.sliderWidth = w;
    
    for (int i = 0; i < self.titleArray.count; i++) {
        
        CGFloat x = w * i;
        
        UIButton *button = [[UIButton alloc] init];
        
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:HQTextColor forState:UIControlStateNormal];
        [button setTitleColor:HQColor forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        
        button.frame = CGRectMake(x, y, w, h);
        [self addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(didClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (button.tag == 0) {
            
            button.selected = YES;
            _tempBtn = button;
        }
    
        /** 创建分割线 */
        UIView *carve = [[UIView alloc] init];
        carve.backgroundColor = HQLineColor;
        carve.frame = CGRectMake(w * (i + 1), 12, 1, 44 - (12 * 2));
        [self addSubview:carve];
    }
    
    /** 创建滑块 */
    UIView *sliderView = [[UIView alloc] init];
    self.sliderView = sliderView;
    sliderView.backgroundColor = HQColor;
    
    /** 滑块高度 */
    CGFloat sliderHeight = 4.f;
    
    sliderView.frame = CGRectMake(0, self.bounds.size.height - sliderHeight, self.sliderWidth, sliderHeight);
    
    [self addSubview:sliderView];
    
    UIView *carve = [[UIView alloc] init];
    carve.backgroundColor = HQLineColor;
    [self addSubview:carve];
    [carve mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)didClickMenuButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(sliderView:didClickMenuButton:)]) {
        [self.delegate sliderView:self didClickMenuButton:button];
    }
    
    /** 当重复点击按钮时,直接返回,什么都不做 */
    if (button == _tempBtn) {
        return;
    }
    
    if (_tempBtn == button) {
        
        button.selected = YES;
        
    } else if (_tempBtn != button) {
        
        _tempBtn.selected = NO;
        button.selected = YES;
        _tempBtn = button;
    }
    
    /** 设置滑块滚动 */
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.x = button.tag * self.sliderWidth;
    }];
}

#pragma mark - 懒加载
- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSArray arrayWithObjects:@"全部", @"待付款", @"已付款", @"退款", nil];
    }
    return _titleArray;
}

@end
