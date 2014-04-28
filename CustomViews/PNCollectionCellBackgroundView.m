//
//  PNCollectionCellBackgroundView.m
//
//  Created by Jay Slupesky on 10/3/12.
//

#import "PNCollectionCellBackgroundView.h"

@implementation PNCollectionCellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

void addRoundedRect(CGContextRef ctx, CGRect rect, float cornerRadius) {
    if (cornerRadius <= 2.0) {
        CGContextAddRect(ctx, rect);
    } else {
        float x_left = rect.origin.x;
        float x_left_center = x_left + cornerRadius;
        float x_right_center = x_left + rect.size.width - cornerRadius;
        float x_right = x_left + rect.size.width;
        float y_top = rect.origin.y;
        float y_top_center = y_top + cornerRadius;
        float y_bottom_center = y_top + rect.size.height - cornerRadius;
        float y_bottom = y_top + rect.size.height;
        /* Begin path */
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, x_left, y_top_center);
        /* First corner */
        CGContextAddArcToPoint(ctx, x_left, y_top, x_left_center, y_top, cornerRadius);
        CGContextAddLineToPoint(ctx, x_right_center, y_top);
        /* Second corner */
        CGContextAddArcToPoint(ctx, x_right, y_top, x_right, y_top_center, cornerRadius);
        CGContextAddLineToPoint(ctx, x_right, y_bottom_center);
        /* Third corner */
        CGContextAddArcToPoint(ctx, x_right, y_bottom, x_right_center, y_bottom, cornerRadius);
        CGContextAddLineToPoint(ctx, x_left_center, y_bottom);
        /* Fourth corner */
        CGContextAddArcToPoint(ctx, x_left, y_bottom, x_left, y_bottom_center, cornerRadius);
        CGContextAddLineToPoint(ctx, x_left, y_top_center);
        /* Done */
        CGContextClosePath(ctx);
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGColorRef cgColorWhite = [UIColor whiteColor].CGColor;

    UIColor* color235Gray = [UIColor colorWithRed:235.0/255.0
                                           green:235.0/255.0
                                            blue:235.0/255.0
                                           alpha:1.0];
    CGColorRef cgColor235Gray = color235Gray.CGColor;

    UIColor* color214Gray = [UIColor colorWithRed:214.0/255.0
                                            green:214.0/255.0
                                             blue:214.0/255.0
                                            alpha:1.0];
    CGColorRef cgColor214Gray = color214Gray.CGColor;
    
    UIColor* color210Gray = [UIColor colorWithRed:210.0/255.0
                                           green:210.0/255.0
                                            blue:210.0/255.0
                                           alpha:1.0];
    CGColorRef cgColor210Gray = color210Gray.CGColor;
    
    UIColor* color190Gray = [UIColor colorWithRed:190.0/255.0
                                            green:190.0/255.0
                                             blue:190.0/255.0
                                            alpha:1.0];
    CGColorRef cgColor190Gray = color190Gray.CGColor;
    
    //Get the CGContext from this view
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // fill all with white
    CGContextSetFillColorWithColor(context,cgColorWhite);
    CGContextFillRect(context,self.bounds);

    CGContextSetLineWidth(context,5.0);
    
    // top
    CGContextSetStrokeColorWithColor(context,cgColor235Gray);
    CGContextMoveToPoint(context,0.0,0.0);
    
    
   
    CGContextAddLineToPoint(context,self.bounds.size.width,0.0);
    CGContextStrokePath(context);
    
    // left
    CGContextSetStrokeColorWithColor(context,cgColor214Gray);
    CGContextMoveToPoint(context,0.0,0.0);
    CGContextAddLineToPoint(context,0.0,self.bounds.size.height);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context,cgColor235Gray);
    CGContextMoveToPoint(context,1.0,0.0);
    CGContextAddLineToPoint(context,1.0,self.bounds.size.height);
    CGContextStrokePath(context);

    // right
    CGContextSetStrokeColorWithColor(context,cgColor235Gray);
    CGContextMoveToPoint(context,self.bounds.size.width - 1.0,0.0);
    CGContextAddLineToPoint(context,self.bounds.size.width - 1.0,self.bounds.size.height);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context,cgColor214Gray);
    CGContextMoveToPoint(context,self.bounds.size.width - 0.0,0.0);
    CGContextAddLineToPoint(context,self.bounds.size.width - 0.0,self.bounds.size.height);
    CGContextStrokePath(context);
    
    // bottom
    CGContextSetStrokeColorWithColor(context,cgColor190Gray);
    CGContextMoveToPoint(context,0.0,self.bounds.size.height - 1.0);
    CGContextAddLineToPoint(context,self.bounds.size.width,self.bounds.size.height - 1.0);
    CGContextStrokePath(context);

    CGContextSetStrokeColorWithColor(context,cgColor210Gray);
    CGContextMoveToPoint(context,0.0,self.bounds.size.height - 0.0);
    CGContextAddLineToPoint(context,self.bounds.size.width,self.bounds.size.height - 0.0);
    
    CGContextStrokePath(context);
    
   [self drawRectWithRect:rect];

}

- (void)drawRectWithRect:(CGRect)rect
{
    // draw a rounded rect bezier path filled with blue
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15.4f];
    [bezierPath setLineWidth:4.0f];
    [[UIColor lightGrayColor] setStroke];
    
    UIColor *fillColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1]; // color equivalent is #87ceeb
    [fillColor setFill];
    
    [bezierPath stroke];
    //[bezierPath fill];
    CGContextRestoreGState(aRef);
}


void addRoundedRect2(CGContextRef ctx, CGRect rect, float cornerRadius) {
    if (cornerRadius <= 2.0) {
        CGContextAddRect(ctx, rect);
    } else {
        float x_left = rect.origin.x;
        float x_left_center = x_left + cornerRadius;
        float x_right_center = x_left + rect.size.width - cornerRadius;
        float x_right = x_left + rect.size.width;
        float y_top = rect.origin.y;
        float y_top_center = y_top + cornerRadius;
        float y_bottom_center = y_top + rect.size.height - cornerRadius;
        float y_bottom = y_top + rect.size.height;
        /* Begin path */
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, x_left, y_top_center);
        /* First corner */
        CGContextAddArcToPoint(ctx, x_left, y_top, x_left_center, y_top, cornerRadius);
        CGContextAddLineToPoint(ctx, x_right_center, y_top);
        /* Second corner */
        CGContextAddArcToPoint(ctx, x_right, y_top, x_right, y_top_center, cornerRadius);
        CGContextAddLineToPoint(ctx, x_right, y_bottom_center);
        /* Third corner */
        CGContextAddArcToPoint(ctx, x_right, y_bottom, x_right_center, y_bottom, cornerRadius);
        CGContextAddLineToPoint(ctx, x_left_center, y_bottom);
        /* Fourth corner */
        CGContextAddArcToPoint(ctx, x_left, y_bottom, x_left, y_bottom_center, cornerRadius);
        CGContextAddLineToPoint(ctx, x_left, y_top_center);
        /* Done */
        CGContextClosePath(ctx);
    }
}

@end
