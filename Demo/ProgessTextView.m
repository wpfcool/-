//
//  ProgessTextView.m
//  Demo
//
//  Created by wenpeifang on 2017/9/14.
//  Copyright © 2017年 wenpeifang. All rights reserved.
//

#import "ProgessTextView.h"
@interface ProgessTextView()
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;//用来控制maskLabel渲染的layer


@property (nonatomic,strong) UILabel * bottomLeftLabel;
@property (nonatomic,strong) UILabel * bottomRightLabel;



@property (nonatomic,strong) UILabel * topLeftLabel;
@property (nonatomic,strong) UILabel * topRightLabel;

@end
@implementation ProgessTextView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initialUI];
    }
    
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initialUI];
    }
    return self;
}

-(void)setProgress:(CGFloat)progress{
    
    _progress = progress;
    
    NSLog(@"%f",self.bounds.size.width * _progress);
    self.maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width*_progress, self.bounds.size.height) cornerRadius:self.bounds.size.height/2.0].CGPath ;

    
}
-(void)initialUI{
    _backTextColor = [UIColor redColor];
    _foreTextColor = [UIColor whiteColor];
    
   _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomView];
    _bottomLeftLabel = [[UILabel alloc]init];
    _bottomLeftLabel.textColor = self.backTextColor;
    [_bottomView addSubview:_bottomLeftLabel];
    
    _bottomRightLabel = [[UILabel alloc]init];
    _bottomRightLabel.textColor = self.backTextColor;
    [_bottomView addSubview:_bottomRightLabel];

    
    
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor clearColor];
    [self addSubview:_topView];
 

    _topLeftLabel = [[UILabel alloc]init];
    _topLeftLabel.textColor =self.foreTextColor;
    [_topView addSubview:_topLeftLabel];
    _topRightLabel = [[UILabel alloc]init];
    _topRightLabel.textColor = self.foreTextColor;
    [_topView addSubview:_topRightLabel];
    
    

    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.anchorPoint = CGPointMake(0, 0);//注意，按默认的anchorPoint，width动画是同时像左右扩展的
    layer.position = CGPointMake(0, 0);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.topView.layer.mask = layer;
    self.maskLayer = layer;
    
    _bottomView.translatesAutoresizingMaskIntoConstraints =NO;
    _topView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _bottomLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _topRightLabel.translatesAutoresizingMaskIntoConstraints  =NO;
    _topLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary * dic = NSDictionaryOfVariableBindings(_bottomView,_topView,_bottomRightLabel,_bottomLeftLabel,_topLeftLabel,_topRightLabel);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bottomView]-0-|" options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bottomView]-0-|" options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_topView]-0-|" options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topView]-0-|" options:0 metrics:nil views:dic]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_bottomLeftLabel]" options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bottomLeftLabel]-0-|" options:0 metrics:nil views:dic]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_bottomRightLabel]-10-|" options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bottomRightLabel]-0-|" options:0 metrics:nil views:dic]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_topLeftLabel]" options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topLeftLabel]-0-|" options:0 metrics:nil views:dic]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_topRightLabel]-10-|" options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topRightLabel]-0-|" options:0 metrics:nil views:dic]];
    
 
}
-(void)setFont:(UIFont *)font{
    _font = font;
    _bottomLeftLabel.font = font;
    _bottomRightLabel.font = font;
    _topLeftLabel.font = font;
    _topRightLabel.font = font;
}
-(void)setLeftText:(NSString *)leftText{
    _leftText = leftText;
    _bottomLeftLabel.text = leftText;
    _topLeftLabel.text = leftText;
}
-(void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    _bottomRightLabel.text = rightText;
    _topRightLabel.text = rightText;
}
//-(void)layoutSubviews{
//    self.maskLayer.bounds = CGRectMake(0, 0, _progress * self.bounds.size.width, self.bounds.size.height);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
