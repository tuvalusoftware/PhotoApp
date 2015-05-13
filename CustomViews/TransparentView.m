//
//  TransparentView.m
//  CustomViews
//
//  Created by TouchROI on 3/12/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "TransparentView.h"

@implementation TransparentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@" touches ended");
    
     
 
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    self.touch  = [anyTouch locationInView:self];
    
   
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
  
    
    UITouch *anyTouch = [touches anyObject];
    CGPoint  newtouch  = [anyTouch locationInView:self];
    
    float distance = self.touch.y - newtouch.y;
    
    
    CGRect tablFrame = self.anyView.frame;
    
    
  
        
        
    CGRect newFrame  = CGRectMake(tablFrame.origin.x, tablFrame.origin.y-distance,SCREEN_WIDTH, tablFrame.size.height +distance);
    
    
    
    
    if(newFrame.origin.y <  100 && newFrame.origin.y > 0 && distance  < 0)
    {
        // if table is scrollded down and direction is up.
        
        NSLog(@" scrolling down");
         self.anyView.frame=newFrame;
        self.userInteractionEnabled = YES;
    }
    else if( newFrame.origin.y <  100 && newFrame.origin.y >  0 && distance  > 0)
    {
        
        self.userInteractionEnabled = YES;
        NSLog(@" scrolling up");
        
        self.anyView.frame=newFrame;
        
    }
    else if(  distance  > 0)
    {
        NSLog(@" scrolling tables");
        
        self.userInteractionEnabled = NO;
    }

    if( newFrame.origin.y <1 && distance > 1  )
    {
           NSLog(@" YES IN RANGE");
       
    }
        
    
    
    //els
   // if table is above 100 and sroll is down
   
    
   
    
  /*  if(tablFrame.origin.y > 100)
    {
        self.userInteractionEnabled = NO;
        
        
    }
    else{
        
        self.anyView.frame=newFrame;
    }*/
    
    
    
    
    NSLog(@"distance %f  newFrame.y= %f", distance, newFrame.origin.y);
  
}



- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@" touches cancelled");
 

}

/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"hit test");
    return [self.superview hitTest:point withEvent:event];
    
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
     NSLog(@"pointinside");
    return [self.superview pointInside:point withEvent:event];
    
}
*/


@end
