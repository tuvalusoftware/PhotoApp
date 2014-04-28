//
//  MyFlowLayout.h
//  CustomViews
//
//  Created by TouchROI on 3/1/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat scaleValue;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) NSIndexPath *selectedCellCoordinates;
 

@end
