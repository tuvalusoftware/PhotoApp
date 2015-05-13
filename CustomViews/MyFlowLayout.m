//
//  MyFlowLayout.m
//  CustomViews
//
//  Created by TouchROI on 3/1/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "MyFlowLayout.h"
#import <math.h>


#define ITEM_SIZEh 50
#define ITEM_SIZEw 74

#define BEHAVIOR_LENGTH     5.0f
#define BEHAVIOR_DAMPING    1.8f;
#define BEHAVIOR_FREQUENCY  10.0f


@implementation MyFlowLayout
-(void) prepareLayout
{
    [super prepareLayout];
    
    // set the siz to the collection view
    CGSize size = self.collectionView.frame.size;
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    
    
    
    /* geometric center of collectio view screen */
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    
    // make the radius as large a possible given the coordinates.
    _radius = MIN(size.width, size.height) / 2.5;

    CGSize contentSize = self.collectionView.contentSize;
    
     self.scrollDirection = UICollectionViewScrollDirectionVertical;
   
    self.minimumLineSpacing = 0.0;
    self.minimumInteritemSpacing = 0.0;
    self.sectionInset = UIEdgeInsetsZero;
    self.footerReferenceSize = CGSizeZero;
    self.headerReferenceSize = CGSizeZero;
    self.sectionInset = UIEdgeInsetsZero;
    
    
    
    NSArray *items = [super layoutAttributesForElementsInRect:
                      CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height  )];
    
    
    if (self.dynamicAnimator.behaviors.count == 0) {
        
        [items enumerateObjectsUsingBlock:^(id<UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:obj
                                                                        attachedToAnchor:[obj center]];
            
            behaviour.length = BEHAVIOR_LENGTH;
            behaviour.damping = BEHAVIOR_DAMPING;
            behaviour.frequency = BEHAVIOR_FREQUENCY;
            
            [self.dynamicAnimator addBehavior:behaviour];
        }];
    }
    
    
}
/*
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
    return CGSizeMake(320, collectionView.frame.size.height-100);
}*/

- (id)init
{
    if (!(self = [super init])) return nil;
    
    /* these settings don't seem to have any affect */
    
   // self.minimumInteritemSpacing = 100;
   // self.minimumLineSpacing = 100;
    //self.itemSize = CGSizeMake(44, 44);
   // self.sectionInset = UIEdgeInsetsMake(100, 100, 100, 100);
    self.scaleValue =1;
        
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/* content size is set so we don't see the content of the cell by scrolling up*/
-(CGSize) collectionViewContentSize
{
    
    return CGSizeMake(SCREEN_WIDTH, _cellCount *60*_scaleValue );
    
 
}
 





//
-(UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    
    
    
    float offset =1;
    
    if(self.collectionView.contentOffset.y <0 )
    {
        offset =-self.collectionView.contentOffset.y;
    }

    attributes.alpha  =     1;
    attributes.size   =     CGSizeMake(SCREEN_WIDTH ,SCREEN_HEIGHT);
    attributes.zIndex =     path.row;
    
    // move the center down as we count the index up
    attributes.center =     CGPointMake(SCREEN_WIDTH/2, CELL_HEIGHT/2 +path.row* 60*_scaleValue   + path.row*offset/8   );
  
    
    return attributes;
    
}
/*
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size;
}
 */

/* loginc for  layoutAttributesForElementsInRect and layoutAttributesForItemAtIndexPath is the same */
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
  
    NSMutableArray *attributes = [NSMutableArray array];
    for (NSInteger i=0; i< self.cellCount; i++)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
       [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }

    return attributes;
}





-(UICollectionViewLayoutAttributes *) initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
 
    attributes.center = CGPointMake(_center.x, _center.y);
    return attributes;
    
}


/* look at this later for more of a safari appearance */

-(UICollectionViewLayoutAttributes *) finalLayoutAttributesForDeletedItemAtIndexPath:itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
 
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
    
}
 

@end


