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
    
  
    
    attributes.size = CGSizeMake(SCREEN_WIDTH ,SCREEN_HEIGHT);
    attributes.zIndex =    path.row;
    attributes.center = CGPointMake(SCREEN_WIDTH/2, path.row* 80+203);
    
    return attributes;
}

@end
