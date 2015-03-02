//
//  ViewController.m
//  Motion
//
//  Created by Chen on 15/2/1.
//  Copyright (c) 2015年 Chen. All rights reserved.
//

#import "ViewController.h"
#import "BallView.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BallView *ballView;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runMotion{
    self.motionManager = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    
    self.motionManager.accelerometerUpdateInterval = 1.0/60.0;
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:
     ^(CMAccelerometerData *accelerometerData, NSError *error) {
         //Set Label
         NSString *labelText;
         if(error){
             [self.motionManager stopAccelerometerUpdates];
             labelText = [NSString stringWithFormat: @"Accelerometer encount error:%@",error];
         }
         else{
             labelText = [NSString stringWithFormat: @"Accelerometer\n---\nx:%+f\ny:%+f\nz:%+f",
                          accelerometerData.acceleration.x,
                          accelerometerData.acceleration.y,
                          accelerometerData.acceleration.z];
         }
         
         [self.accelerometerLabel performSelectorOnMainThread:@selector(setText:)
                                                   withObject:labelText
                                                waitUntilDone:NO];
         
         [(id)self.ballView setAcceleration:accelerometerData.acceleration];
         [self.ballView performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
     }];
    
    
    self.motionManager.gyroUpdateInterval = 1.0/10.0;
    [self.motionManager startGyroUpdatesToQueue: self.queue withHandler:
     ^(CMGyroData *gyroData, NSError *error) {
         NSString *labelText;
         if (error) {
             [self.motionManager stopGyroUpdates];
             labelText = [NSString stringWithFormat:@"Gyroscope encount error:%@",error];
         }
         else{
             labelText = [NSString stringWithFormat:@"Gyroscope\n---\nx:%+f\ny:%+f\nz:%+f",
                          gyroData.rotationRate.x,
                          gyroData.rotationRate.y,
                          gyroData.rotationRate.z];
         }
         
         [self.gyrosopeLabel performSelectorOnMainThread:@selector(setText:)
                                              withObject:labelText
                                           waitUntilDone:NO];
     }];
}

- (IBAction)switchAction:(UIButton *)sender {
    if([[sender titleForState:UIControlStateNormal] isEqual: @"Start Motion"]){
        [self.controlButton setTitle:@"Stop Motion" forState:UIControlStateNormal];
        [self runMotion];
    }
    else if([[sender titleForState:UIControlStateNormal] isEqual: @"Stop Motion"]){
        [self.controlButton setTitle:@"Start Motion" forState:UIControlStateNormal];
        [self.motionManager stopAccelerometerUpdates];
        [self.motionManager stopGyroUpdates];
        //[self.accelerometerLabel setText:@""];
        //[self.gyrosopeLabel setText:@""];
        [self.ballView stopUpdate]  ;
    }
}
@end
