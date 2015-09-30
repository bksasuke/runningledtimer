//
//  ViewController.m
//  R_Led_timer
//
//  Created by student on 9/28/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


{
    CGFloat _margin; //> ball radius
    int _numberOfBall;
    CGFloat _space; //>balldiameter
    CGFloat _ballDiameter;
    NSTimer * _timer; // indicate instant variable
    int lastOnLed; //store last turn on Led
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin =40.0;
    _ballDiameter=29.0;
    _numberOfBall =8;
    lastOnLed =-1;
    [self checkSizeOfApp];
    [self numberOfBallvsSpace];
    [self drawRowOfBalls: _numberOfBall ];
    _timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(r_Led) userInfo:nil repeats:true];
}
-(void) r_Led {
    [self turnOffLed:lastOnLed];
   if ( lastOnLed <112)
       lastOnLed++;
   else  lastOnLed= -1;
    
    [self turnOnLed:lastOnLed];
    
}
-(void) turnOnLed: (int) index {
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}
-(void) turnOffLed: (int) index {
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"blue"];
    }
}

-(void) placeGrayBallAtX: (CGFloat) x
                    andY: (CGFloat) y
                 withTag:(int)tag

{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
    ball.center =CGPointMake(x, y);
    ball.tag =tag ;
    [self.view addSubview:ball];
    NSLog(@"%d",tag);
    //    NSLog(@"w=%3.0f, h=%3.0f", ball.bounds.size.width, ball.bounds.size.height);
}
-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) n{
    return(self.view.bounds.size.width - 2 * _margin) /(n-1);
    
}

-(void) numberOfBallvsSpace {
    bool stop = false;
    int n = 2;
    while (!stop){
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown: n];
        
        if (space < _ballDiameter){
            stop =true;
        } else {
            //NSLog(@"Number of ball:%d, space between ball center:%3.0f", n, space);
        }n++;
    }
}

-(void) drawRowOfBalls: (int) numberBalls {
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberBalls];
    for(int j =0; j < 14; j++) {
        for(int i =0; i< 8; i++)
        {
            [self placeGrayBallAtX:_margin +i * space
                              andY:_margin +j *space
                           withTag: (j+1)*_numberOfBall -i +100];
        }
    }
}

-(void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %3.0f, height = %3.0f", size.width, size.height);
}
@end

