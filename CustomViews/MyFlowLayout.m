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

@implementation MyFlowLayout
-(void) prepareLayout
{
    [super prepareLayout];
    CGSize size = self.collectionView.frame.size;
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    _radius = MIN(size.width, size.height) / 2.5;
    
    
    
    
   
    
    
    CGSize contentSize = self.collectionView.contentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:
                      CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height)];
    
    
    if (self.dynamicAnimator.behaviors.count == 0) {
        [items enumerateObjectsUsingBlock:^(id<UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:obj
                                                                        attachedToAnchor:[obj center]];
            
            behaviour.length = 5.0f;
            behaviour.damping = 6.8f;
            behaviour.frequency = 3.0f;
            
            [self.dynamicAnimator addBehavior:behaviour];
        }];
    }
    
    
}



- (id)init
{
    if (!(self = [super init])) return nil;
    
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(44, 44);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.scaleValue =1;
        
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGSize) collectionViewContentSize
{
    //return [self collectionView].frame.size ;
    
    //CGSize size = [super collectionViewContentSize];
    return CGSizeMake(320, 3000);
    
    
}




-(UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    
    
    
    float offset =1;
    
     if(self.collectionView.contentOffset.y <0 )
     {
         
         offset =-self.collectionView.contentOffset.y;
     }
    
    

    
     attributes.alpha = 1;
    
     attributes.size = CGSizeMake(320 ,400);
     attributes.zIndex =    path.row;
    
   // NSLog(@"offset %f", offset );
    
    if( offset >1   )
       attributes.center = CGPointMake(320/2, path.row* 60*_scaleValue  + path.row*offset/8  +203);
    else
    {
        attributes.center = CGPointMake(320/2, path.row* 60*_scaleValue+203);
        
    }
    
    return attributes;
    
}

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

-(UICollectionViewLayoutAttributes *) finalLayoutAttributesForDeletedItemAtIndexPath:itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
 
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
    
}
 

@end


