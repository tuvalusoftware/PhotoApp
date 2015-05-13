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
@class RBMenu;
@class btSimplePopUP;

@interface CollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) IBOutlet TransparentView *myView;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRecognizer;

@property (strong) RBMenu* menu;

@property NSArray *dataArray;

@property   BOOL itemSelected;
@property(nonatomic,strong )UIImageView *backGroundBlurr;
@property   CGPoint   contentOffset;
@property   float    oldScale;
@property   float    startScale;
@property   float    scale;
@property   BOOL  isTransitioning;
@property btSimplePopUP * popUp;

-(void) snapView:(UIView*) view point:(CGPoint) point;
-(void) snapBackView:(UIView*) view point:(CGPoint) point;

@end
