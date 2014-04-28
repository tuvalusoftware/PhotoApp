//
//  CollectionViewController.h
//  CustomViews
//
//  Created by TouchROI on 3/1/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import <UIKit/UIKit.h>

//UICollectionViewLayout
@class TransparentView;

@interface CollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) IBOutlet TransparentView *myView;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRecognizer;

@property   BOOL itemSelected;

@property   CGPoint   contentOffset;

-(UIImageView*) addTakeImage:(UIView*) view;
-(IBAction)handlePinch:(UIPinchGestureRecognizer*)sender;
@end
