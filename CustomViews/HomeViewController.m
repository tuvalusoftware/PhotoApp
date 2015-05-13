//
//  HomeViewController.m
//  CustomViews
//
//  Created by TouchROI on 12/21/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "HomeViewController.h"
#import "CollectionViewController.h"
#import "AssetGridViewController.h"
#import "GGTabBarController.h"
#import "GGTabBarAppearanceKeys.h"


@import Photos;

@import UIKit;

/* placement of the photo grid*/
#define GRID_WIDTH_LEFT_OFFSET  2.0f
#define GRID_HEIGHT_TOP_OFFSET 50.0f
#define GRID_WIDTH_RIGHT_OFFSET 2.0f
#define GRID_HEIGHT_TOP_OFFSET 50.0f
#define GRID_WIDTH_HIEGHT_BOTTOM_OFFSET 50.0f



/* attibutes for displaying the (photo) grid */
#define SHOW_PHOTO_GRID_DURATION  0.6f
#define SHOW_PHOTO_GRID_DELAY     0.2f


@implementation HomeViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    /* be notified when its time to transition the view up*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(up:)
                                                 name:MESSAGE_CELL_UP object:nil];
    
    
    /* register for notification when its time to transition the view down*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(down:)
                                                 name:MESSAGE_CELL_DOWN object:nil];
}




/*
   Take a snapshot of the image.
 
 */
-(UIImageView*) addTakeImage:(UIView*) view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView* imageView = [[UIImageView alloc] initWithImage:img];
    return imageView;
  
}

/* transition the cell up */
-(IBAction)up:(NSNotification*) notification
{
    
 
    
    
    
    NSDictionary * dict = notification.userInfo;
    
  //  CGRect currentRect = CGRectFromString([dict objectForKey:@"coordinates"]);
      UIImageView* iView = [dict objectForKey:@"imageView"];
  //  NSNumber* number =   [dict objectForKey:@"index"];
    
    UIColor* color = (UIColor*) [dict objectForKey:@"color"];
   
    _ctrl = [dict objectForKey:@"control"];
 
    //Snap the control to the the top
    [_ctrl  snapView:iView point:CGPointMake(SCREEN_WIDTH/2,(SCREEN_HEIGHT)/2+70)];
    

    
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    CGRect rect = iView.frame;
    
    // configure the grid control
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    _gridController  = [sb instantiateViewControllerWithIdentifier:@"AssetGrid"];
    _gridController.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    // add the gred controller with slight offsets.
       _gridController.view.frame = CGRectMake(GRID_WIDTH_LEFT_OFFSET,GRID_HEIGHT_TOP_OFFSET+60 ,rect.size.width-GRID_WIDTH_LEFT_OFFSET+GRID_WIDTH_RIGHT_OFFSET,rect.size.height- GRID_WIDTH_HIEGHT_BOTTOM_OFFSET );
    
    
    //_gridController.view.backgroundColor = [UIColor redColor];
    _gridController.collectionView.backgroundColor =color;
    
    // add the grid control to the view.
    [_ctrl.view addSubview:_gridController.view];
    
    /* set the grid control alpha to make it invisible while transitionin is in progress */
     _gridController.view.alpha =0;
    
    [UIView animateWithDuration:SHOW_PHOTO_GRID_DURATION
                          delay:SHOW_PHOTO_GRID_DELAY
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                     _gridController.view.alpha =1;
                      
                     }
                     completion:^(BOOL finished){
                                             }];
 

    
    
    
}




/* transitioning down */
-(IBAction)down:(NSNotification*) notification
{
 
    NSDictionary * dict = notification.userInfo;
    
    CGRect currentRect = CGRectFromString([dict objectForKey:@"coordinates"]);
    UIImageView* iView = [dict objectForKey:@"imageView"];
   // NSNumber* number =   [dict objectForKey:@"index"];
    CollectionViewController* ctrl = [dict objectForKey:@"control"];
    
    
    // snap back to this position.
    [ctrl snapBackView:iView point:CGPointMake(SCREEN_WIDTH/2,currentRect.origin.y+currentRect.size.height*.5)];
 
    [_gridController.view removeFromSuperview];
    
    
    
}

- (IBAction)goAgain:(id)sender
{
    _tabBar = [[GGTabBarController alloc] init];
    _tabBar.tabBarAppearanceSettings = @{kTabBarAppearanceHeight : @(100), kTabBarAppearanceBackgroundColor:[UIColor redColor]}; // in points
    
    // configure the grid control
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   _collectionsCtrl   = [sb instantiateViewControllerWithIdentifier:@"Albums"];
     _collectionsCtrl2   = [sb instantiateViewControllerWithIdentifier:@"Albums"];
    _collectionsCtrl.dataArray = @[@[@"All Photos",@"Favorites", @"Recently Deleted", @"All Photos", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                   @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                   @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                   @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1"]];
    
    
    
    _collectionsCtrl2.dataArray =@[@ [@"Some Photos",@"Favorites", @"Recently Deleted", @"All Photos", @"aFolder1", @"a Folder1", @"MaFolder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                     @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                     @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                     @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1"]];

 
    
    
    _tabBar.viewControllers = @[_collectionsCtrl,_collectionsCtrl2];
 
    
    [self.view addSubview:_tabBar.view];
  
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
  
    
    CollectionViewController* collectionCtrl = (CollectionViewController*) [segue destinationViewController];
    
    collectionCtrl.dataArray = @[@[@"All Photos",@"Favorites", @"Recently Deleted", @"All Photos", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                   @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                   @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1",
                                   @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1", @"My Folder1"]];
    
    

    
 
}




@end
