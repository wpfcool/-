//
//  ProgressView.m
//  Demo
//
//  Created by wenpeifang on 2017/9/13.
//  Copyright © 2017年 wenpeifang. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()
@property (nonatomic,strong)UIImageView * bgImageView;
@property (nonatomic,strong)UIImageView * foreImageView;
@property (nonatomic,strong)UIProgressView * progressView;



/**
 *  屏帧定时器
 */
@property (nonatomic,strong)CADisplayLink *link;

@end
@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    }
    
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initial];
    }
    return self;
}

-(void)initial{
    _animation = YES;
    _textView = [[ProgessTextView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];

    _textView.font = [UIFont systemFontOfSize:10];
    [self addSubview:_textView];
    _borderWidth = 1;
    self.progress = 0;
    _contentTextFont = 9;
    _colorWidth = 10;
    _backgroundColor1 =[UIColor colorWithRed:253/255.0 green:241/255.0 blue:240/255.0 alpha:1];
    _backgroundColor2 =[UIColor colorWithRed:254/255.0 green:227/255.0 blue:227/255.0 alpha:1];
    
    _foregroundColor1=[UIColor colorWithRed:252.0/255.0 green:87/255.0 blue:76/255.0 alpha:1];
    _foregroundColor2 = [UIColor colorWithRed:252/255.0 green:61/255.0 blue:58/255.0 alpha:1];
    _padding = 6;
}

-(void)setBackgroundColor1:(UIColor *)backgroundColor1{
    _backgroundColor1 = backgroundColor1;
    [self setNeedsDisplay];

}
-(void)setBackgroundColor2:(UIColor *)backgroundColor2{
    _backgroundColor2 = backgroundColor2;
    [self setNeedsDisplay];
}
-(void)setForegroundColor1:(UIColor *)foregroundColor1{
    _foregroundColor1 = foregroundColor1;
    [self setNeedsDisplay];
}
-(void)setForegroundColor2:(UIColor *)foregroundColor2{
    _foregroundColor2 = foregroundColor2;
    [self setNeedsDisplay];
}
-(void)setPadding:(CGFloat)padding{
    _padding = padding;
    [self setNeedsDisplay];
}
-(void)setColorWidth:(CGFloat)colorWidth{
    _colorWidth = colorWidth;
    [self setNeedsDisplay];
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    _textView.progress = progress;
    
    if(_controlProgress > 0){
        if(_progress > _controlProgress){
            if(!_textView.isHidden){
                _textView.hidden = YES;
            }
        
        }
        else{
            if(_textView.isHidden){
                _textView.hidden = NO;
            }

        }
        
    }
    if (self.animation) {
        self.link.paused = NO;
    }
    [self setNeedsDisplay];
}
- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    self.progress = 0;
}

-(void)drawParallelogram:(CGRect)rect content:(CGContextRef)context color:(UIColor *)color{
    CGContextSaveGState(context);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height/2.0] addClip];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGFloat xStart = -5, height = rect.size.height;
    while (xStart < rect.size.width) {
        CGContextSaveGState(context);
        CGContextMoveToPoint(context, xStart, height);
        CGContextAddLineToPoint(context, xStart + 10 , 0);
        CGContextAddLineToPoint(context, xStart + 10+_colorWidth, 0);
        CGContextAddLineToPoint(context, xStart + _colorWidth, height);
        CGContextClosePath(context);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        xStart += (_colorWidth+_padding);
    }
    
    CGContextRestoreGState(context);
}

-(void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, TRUE);
    
    CGRect currentRect = rect;
    CGFloat radius;
    CGFloat halfLineWidth;
    //画背景框
    radius = currentRect.size.height / 2;
    [self.backgroundColor1 setFill];
    fillRoundedRectInContext(context, currentRect, radius);
    
    
    [self drawParallelogram:currentRect content:context color:self.backgroundColor2];
    

    if(_progress>0){
        CGContextSaveGState(context);

        CGRect  progressRect = CGRectMake(0, 0, _progress * currentRect.size.width, currentRect.size.height);
        CGFloat radius = progressRect.size.height/2.0;
        [self.foregroundColor1 setFill];
        fillRoundedRectInContext(context, progressRect, radius);

        [self drawParallelogram:progressRect content:context color:self.foregroundColor2];
    }
    if(_borderWidth > 0){
        halfLineWidth = self.borderWidth / 2.0;
        currentRect = CGRectInset(currentRect, halfLineWidth, halfLineWidth);
        radius = currentRect.size.height / 2;

        [[UIColor redColor] setStroke];
        strokeRoundedRectInContext(context, currentRect, self.borderWidth, radius);
    }
    
    if(_controlProgress > 0){
        if(_progress > _controlProgress){
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.alignment = NSTextAlignmentCenter;
            [_contentText drawInRect:currentRect withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:_contentTextFont],NSForegroundColorAttributeName:[UIColor whiteColor],NSParagraphStyleAttributeName:paragraph}];
        }
        
    }


    
}

void strokeRoundedRectInContext(CGContextRef context, CGRect rect, CGFloat lineWidth, CGFloat radius)
{
    CGContextSetLineWidth(context, lineWidth);
    setRoundedRectPathInContext(context, rect, radius);
    CGContextStrokePath(context);
}

void fillRoundedRectInContext(CGContextRef context, CGRect rect, CGFloat radius)
{
    setRoundedRectPathInContext(context, rect, radius);
    CGContextFillPath(context);
}

void setRoundedRectPathInContext(CGContextRef context, CGRect rect, CGFloat radius)
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
    CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius);
    CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius);
    CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius);
    CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius);
    CGContextClosePath(context);
}
-(void)startAnimationIfNeed{
    if (self.progress < self.progressValue) {
        self.progress +=0.02;
        [self setNeedsDisplay];
    }
    else{
        self.link.paused = YES;
        [self.link invalidate];
        self.link = nil;
    }
}
#pragma makr - 懒加载定时器
-(CADisplayLink *)link{
    if (_link == nil && self.animation == YES) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAnimationIfNeed)];
        _link.frameInterval = 1;
        
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}



-(void)setFont:(CGFloat)font{
    _font = font;
    _textView.font = [UIFont systemFontOfSize:font];
}
-(void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    _textView.rightText = rightText;
}
-(void)setLeftText:(NSString *)leftText{
    _leftText = leftText;
    _textView.leftText = leftText;
}
-(void)setTopColor:(UIColor *)topColor{
    _topColor = topColor;
    _textView.foreTextColor  =topColor;
}
-(void)setBottomColor:(UIColor *)bottomColor{
    _bottomColor = bottomColor;
    _textView.backTextColor = bottomColor;
}
@end
