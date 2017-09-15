//
//  ViewController.m
//  Demo
//
//  Created by wenpeifang on 2017/9/13.
//  Copyright © 2017年 wenpeifang. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@property (strong, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _progressView.leftText = @"已售80件";
    _progressView.rightText  =@"80%";
    _progressView.controlProgress = 0.8;
    _progressView.contentText = @"即将售罄";
    _progressView.progress = self.slider.value;
    
}
- (IBAction)sliderChanged:(id)sender {
      _progressView.progress = self.slider.value;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
