//
//  CVCell.m
//  CollectionViewExample
//
//  Created by Tim on 9/5/12.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CVCell.h"
#import "PNCollectionCellBackgroundView.h"

@implementation CVCell

{
    CGFloat _shadowWidth;
}

@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // load the nib CVCell
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CVCell" owner:self options:nil];
        
        
        // check there is at least one view.
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        
        // check the view at index 0 is indeed an instance of UICollectionViewCell
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        // set self to be and instance of the object returned from nib
        self = [arrayOfViews objectAtIndex:0];
        
        //No longer using backgrond view. 
          // create a round rect background group.
        //  PNCollectionCellBackgroundView* backgroundView = //[[PNCollectionCellBackgroundView alloc] initWithFrame:frame];
        
       // self.backgroundView=backgroundView;
     
        
    }
    
    return self;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    if (_shadowWidth != bounds.size.width)
    {
        if (_shadowWidth == 0)
 
        {
            [self.layer setMasksToBounds:NO ];
            [self.layer setShadowColor:[[UIColor blackColor ] CGColor ] ];
            [self.layer setShadowOpacity:0.5 ];
            [self.layer setShadowRadius:4.0 ];
            [self.layer setShadowOffset:CGSizeMake( 0 , 0 ) ];
            self.layer.cornerRadius =7.0;
        }
        [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:bounds ] CGPath ] ];
        _shadowWidth = bounds.size.width;
    }
    
}




-(void) applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
      [self setNeedsDisplay];
    
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay]; // force drawRect:
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
