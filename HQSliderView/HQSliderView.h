//
//  HQSliderView.h
//  Unicare
//
//  Created by 王红庆 on 16/10/9.
//  Copyright © 2016年 王红庆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HQSliderView;

@protocol HQSliderViewDelegate <NSObject>

- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button;

@end

@interface HQSliderView : UIView

@property (nonatomic, weak) id <HQSliderViewDelegate> delegate;

@end
