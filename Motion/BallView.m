//
//  BallView.m
//  Motion
//
//  Created by Chen on 15/2/1.
//  Copyright (c) 2015年 Chen. All rights reserved.
//

#import "BallView.h"

static NSDate *lastUpdateTime = nil;

@implementation BallView


-(void) commonInit
{
    self.image = [UIImage imageNamed:@"ball.png"];
    
    self.currentPoint = CGPointMake((self.bounds.size.width / 2.0f)-(self.image.size.width / 2.0f),
                                    (self.bounds.size.height / 2.0f) - (self.image.size.height / 2.0f));
    
}

-(id) initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if(self){
        [self commonInit];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self commonInit];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self.image drawAtPoint:self.currentPoint];
}

-(void) setCurrentPoint:(CGPoint)newPoint
{
    self.previousPoint = self.currentPoint;
    _currentPoint = newPoint;
    
    if (self.currentPoint.x<0) {
        _currentPoint.x =0;
        self.ballXVelocity = -(self.ballXVelocity/2.0f);
    }
    
    if(self.currentPoint.y<0){
        _currentPoint.y = 0;
        self.ballYVelocity = -(self.ballYVelocity/2.0f);
        
    }
    
    if(self.currentPoint.x >self.bounds.size.width - self.image.size.width){
        _currentPoint.x =self.bounds.size.width - self.image.size.width;
        self.ballXVelocity = -(self.ballXVelocity/1.5f);
    }
    
    if(self.currentPoint.y >self.bounds.size.height - self.image.size.height){
        _currentPoint.y =self.bounds.size.height - self.image.size.height;
        self.ballYVelocity = -(self.ballYVelocity/1.5f);
    }
    
    CGRect currentImageRect = CGRectMake(self.currentPoint.x, self.currentPoint.y, self.currentPoint.x + self.image.size.width,
                                         self.currentPoint.y + self.image.size.height);
    
    CGRect previousImageRect = CGRectMake(self.previousPoint.x, self.previousPoint.y, self.previousPoint.x + self.image.size.width,
                                         self.previousPoint.y + self.image.size.height);
    
    [self setNeedsDisplayInRect:CGRectUnion(currentImageRect, previousImageRect)];
}

-(void) update{
    
    if(lastUpdateTime != nil){
        NSTimeInterval secondsSinceLastDraw = -([lastUpdateTime timeIntervalSinceNow]);
        
        self.ballYVelocity = self.ballYVelocity - (self.acceleration.y * secondsSinceLastDraw);
        self.ballXVelocity = self.ballXVelocity + (self.acceleration.x * secondsSinceLastDraw);
        
        CGFloat xAcceleration = secondsSinceLastDraw * self.ballXVelocity*450;
        CGFloat yAcceleration = secondsSinceLastDraw * self.ballYVelocity*450;
        
        self.currentPoint = CGPointMake(self.currentPoint.x + xAcceleration, self.currentPoint.y + yAcceleration);
    }
    
    lastUpdateTime = [[NSDate alloc]init];
    
}

-(void) stopUpdate{
    lastUpdateTime = nil;
}



@end
