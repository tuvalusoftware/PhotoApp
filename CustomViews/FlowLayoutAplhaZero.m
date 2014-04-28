//
//  FlowLayoutAplhaZero.m
//  CustomViews
//
//  Created by TouchROI on 3/5/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "FlowLayoutAplhaZero.h"

@implementation FlowLayoutAplhaZero

-(UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    if(self.selectedCellCoordinates.row != path.row)
    {
        attributes.alpha = 0.0;
        
        
    }
    
  
    
    attributes.size = CGSizeMake(320 ,400);
    attributes.zIndex =    path.row;
    attributes.center = CGPointMake(320/2, path.row* 80+203);
    
    return attributes;
}

@end
