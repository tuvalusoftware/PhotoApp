//
//  MakeAllInvisible.m
//  CustomViews
//
//  Created by TouchROI on 3/5/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "MakeAllInvisible.h"

@implementation MakeAllInvisible


-(UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    
    
  
    
    
    if(self.selectedCellCoordinates.row != path.row)
    {
        attributes.alpha = 0.0;
        
        
    }
       return attributes;
}

@end
