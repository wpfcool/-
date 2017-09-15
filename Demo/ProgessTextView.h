//
//  ProgessTextView.h
//  Demo
//
//  Created by wenpeifang on 2017/9/14.
//  Copyright © 2017年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgessTextView : UIView
@property (nonatomic,assign)CGFloat progress;
@property (nonatomic,strong)UIColor * backTextColor;//下面字体颜色
@property (nonatomic,strong)UIColor * foreTextColor;//上面字体颜色

@property (nonatomic,copy)NSString * leftText;
@property (nonatomic,copy)NSString * rightText;
@property (nonatomic,strong)UIFont * font;
@end
