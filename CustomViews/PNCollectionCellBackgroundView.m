

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
- (void)viewDidLoad
{
  //  self.backgroundColor = [UIColor redColor];
    
    
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


- (void)drawRect:(CGRect)rect
{
    
  /*
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
   */
    
   [self drawRectWithRect:rect];

}

-(void) drawClearRect:(CGRect) rect
{
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    
    
    UIBezierPath *bezierPath  = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15.4f];
    UIBezierPath *bezierPathBackground = [UIBezierPath bezierPathWithRect:rect];
    [bezierPath setLineWidth:4.0f];
    [[UIColor yellowColor] setStroke];
    
    [[UIColor whiteColor] setFill];
 
    
    [bezierPathBackground fill];
    
    // this draws  background (white color)  color
    // [[self getColor] setFill];
    
    [bezierPath fill];
    CGContextRestoreGState(aRef);
    
}



- (void)drawRectWithRect:(CGRect)rect
{
    
    [self drawClearRect:rect];
    // draw a rounded rect bezier path filled with blue
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15.4f];
    [bezierPath setLineWidth:4.0f];
    // NB adding blue color
    UIColor* color = [UIColor colorWithRed:54.0f/255.0f
                                     green:205.0f/255.0f
                                      blue:253.0f/255.0f
                                     alpha:1];
    
    [color setStroke];
    
    UIColor* color2 = [self getColor];
    
    [color2 setFill];
    
    
   // //NB
     [bezierPath stroke];
     //[bezierPath fill];
 
    CGContextRestoreGState(aRef);
    
    
    
}

-(UIColor*) getColor
{
    // Generate a random color
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
    
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
