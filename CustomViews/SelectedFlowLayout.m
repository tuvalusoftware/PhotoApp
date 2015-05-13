//
//  SelectedFlowLayout.m
//  CustomViews
//
//  Created by TouchROI on 3/5/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "SelectedFlowLayout.h"

@implementation SelectedFlowLayout

-(UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
   
    
    attributes.size = CGSizeMake(SCREEN_WIDTH ,SCREEN_HEIGHT);
    
    
    if(self.selectedCellCoordinates.row == path.row)
    {
         attributes.alpha = 1.0;
         attributes.zIndex =0;
        
    }
    else if( path.row ==0 &&  self.selectedCellCoordinates.row !=  0)
    {
        attributes.alpha = 0.0;
        attributes.zIndex=self.selectedCellCoordinates.row;
    }
    else
    {
       attributes.alpha = 0.0;
       attributes.zIndex =    path.row;
    }
    
    attributes.center = CGPointMake(SCREEN_WIDTH/2, 203);
    
    
    
    return attributes;
}

@end
