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

@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CVCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
          PNCollectionCellBackgroundView* backgroundView = [[PNCollectionCellBackgroundView alloc] initWithFrame:frame];
        
        self.backgroundView=backgroundView;
        
    }
    
    return self;
    
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
