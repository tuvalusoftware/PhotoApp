//
//  MakeAllVisible.m
//  CustomViews
//
//  Created by TouchROI on 3/5/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "MakeAllVisible.h"

@implementation MakeAllVisible

-(UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    
    
    
    
    
    
        attributes.alpha = 1.0;
        
        
    
     
    return attributes;
}

@end
