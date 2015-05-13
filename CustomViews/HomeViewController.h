//
//  HomeViewController.h
//  CustomViews
//
//  Created by TouchROI on 12/21/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AssetGridViewController;
@class CollectionViewController;
@class GGTabBarController;

@interface HomeViewController : UIViewController

@property (strong)   UIView * naView;
@property AssetGridViewController* gridController;
@property float lastOriginY;
@property  CollectionViewController* ctrl;
@property CollectionViewController* collectionsCtrl;
@property CollectionViewController* collectionsCtrl2;
@property   GGTabBarController *tabBar;
@end
