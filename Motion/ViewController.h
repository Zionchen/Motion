//
//  ViewController.h
//  Motion
//
//  Created by Chen on 15/2/1.
//  Copyright (c) 2015年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *accelerometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyrosopeLabel;
@property (weak, nonatomic) IBOutlet UIButton *controlButton;

- (IBAction)switchAction:(UIButton *)sender;

@end

