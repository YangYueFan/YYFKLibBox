//
//  LKMainTopView.m
//  LinekeLive
//
//  Created by CODER_TJ on 2017/6/24.
//  Copyright © 2017年 CODER_TJ. All rights reserved.
//

#import "LKSegmentItemBar.h"
#import "YYFKLibBox-Swift.h"

@interface LKSegmentItemBar()

@property (nonatomic, strong) NSMutableArray *buttonGroup;
@property (nonatomic, strong) UIView         *segmentLine; //线条指示器

@end

@implementation LKSegmentItemBar

#pragma mark - Lazy
- (NSMutableArray *)buttonGroup {
    
    if (!_buttonGroup) {
        
        _buttonGroup = [NSMutableArray array];
    }
    return _buttonGroup;
}


#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame segmentItems:(NSArray <NSString *>*)items {
    
    if (self = [super initWithFrame:frame]) {
        CGFloat btnH = self.frame.size.height;
        CGFloat btnW = self.frame.size.width / items.count ;
        self.isAnima = YES;
        CGFloat x = 0;
        for (NSInteger idx = 0; idx < items.count; idx++)
        {
//CGSize titleSize = [items[idx] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
//            CGSize titleSize = [items[idx] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            UIButton *titleItem = [UIButton buttonWithType:UIButtonTypeCustom];
            titleItem.titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleItem setTitle:items[idx] forState:UIControlStateNormal];
            [titleItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            titleItem.tag = idx; //tag值绑定
            
            titleItem.frame = CGRectMake(x, 0, btnW , btnH);
            
            titleItem.titleLabel.font = [UIFont systemFontOfSize:17];
            [titleItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:titleItem]; //添加按钮
            [self.buttonGroup addObject:titleItem];
            
            x = x + btnW;
            
            if (idx == 0) {
                CGFloat h = 2; //线条的高度
                CGFloat y = 40; //self.height - 10;
                [titleItem.titleLabel sizeToFit];
    
                self.segmentLine = [[UIView alloc] init];
                self.segmentLine.layer.cornerRadius = h * 0.5;
                self.segmentLine.layer.masksToBounds = YES;
                self.segmentLine.backgroundColor = [UIColor whiteColor];
                self.segmentLine.height  = h;
                self.segmentLine.width   = titleItem.titleLabel.width;
                self.segmentLine.centerX = titleItem.centerX;
                self.segmentLine.top     = y;
                [self addSubview:self.segmentLine];
            }
        }
    }
    
    return self;
}

#pragma mark - Setter
- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    
    self.segmentLine.backgroundColor = tintColor;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitleColor:tintColor forState:UIControlStateNormal];
        }
    }
}

#pragma mark -
#pragma mark - Cycle scrolling
//滑动控制器时调用title自动滚动
- (void)scrolling:(NSInteger)index
{
    UIButton *button = self.buttonGroup[index]; //拿到按钮
    [self scrollEnd:button];
}

- (void)itemClick:(UIButton *)button {
    [self addCATransition:button];
    
    if (self.didFinishedBlock) {
        self.didFinishedBlock(button.tag);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segment:DidSelectItemAtIndex:)]) {
        
        [self.delegate segment:self DidSelectItemAtIndex:button.tag];
    }
    
    [self scrolling:button.tag];
}

// 添加点击水波纹动画
- (void)addCATransition:(UIButton *)button {
    if (self.isAnima == NO) return;
    
    CATransition *anima = [CATransition animation];
    //设置动画的格式
    anima.type = @"rippleEffect";
    //设置动画的方向
    anima.subtype = @"fromBottom";
    //设置动画的持续时间
    anima.duration = 1;
    [button.layer addAnimation:anima forKey:nil];
}

- (void)scrollEnd:(UIButton *)button {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.segmentLine.centerX = button.centerX;
        
    }];
}


@end
