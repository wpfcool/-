//
//  ProgressView.h
//  Demo
//
//  Created by wenpeifang on 2017/9/13.
//  Copyright © 2017年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgessTextView.h"
@interface ProgressView : UIView
@property (nonatomic,strong)ProgessTextView * textView;
@property (nonatomic,assign)CGFloat borderWidth;

@property (nonatomic,assign)CGFloat progress;

@property (nonatomic,assign)CGFloat progressValue;//执行动画请设置

/**
 *  是否执行动画
 */
@property (nonatomic,assign,getter=isAnimation)BOOL animation;

@property (nonatomic,assign)CGFloat controlProgress;//如果设置当进度大约此值时隐藏Label并显示contentText
@property (nonatomic,copy)  NSString * contentText;//进度条上字体
@property (nonatomic,assign) CGFloat contentTextFont;
@property (nonatomic,assign)CGFloat colorWidth;//颜色宽度(backgroundColor2)
@property (nonatomic,assign)CGFloat padding;//颜色间隔
@property (nonatomic,strong)UIColor * backgroundColor1;
@property (nonatomic,strong)UIColor * backgroundColor2;

@property (nonatomic,strong)UIColor * foregroundColor1;
@property (nonatomic,strong)UIColor * foregroundColor2;

//关于ProgessTextView 的设置
@property (nonatomic,assign)CGFloat font;//字体大小
@property (nonatomic,copy) NSString * leftText;
@property (nonatomic,copy) NSString * rightText;
@property (nonatomic,strong) UIColor * topColor;
@property (nonatomic,strong)UIColor  * bottomColor;
@end
