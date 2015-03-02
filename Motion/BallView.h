//
//  BallView.h
//  Motion
//
//  Created by Chen on 15/2/1.
//  Copyright (c) 2015年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface BallView: UIView

@property (strong,nonatomic) UIImage *image;
@property (assign,nonatomic) CGPoint currentPoint;
@property (assign,nonatomic) CGPoint previousPoint;
@property (assign,nonatomic) CMAcceleration acceleration;
@property (assign,nonatomic) CGFloat ballXVelocity;
@property (assign,nonatomic) CGFloat ballYVelocity;

-(void) stopUpdate;

@end
