//
//  CollectionViewController.m
//  CustomViews
//
//  Created by TouchROI on 3/1/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.

// Preconfigure Filters
//

#import "CollectionViewController.h"
#import "CVCell.h"
#import "MyFlowLayout.h"
#import "THSpringyFlowLayout.h"
#import "PNCollectionCellBackgroundView.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectedFlowLayout.h"
#import "CVCell.h"
#import "MakeAllVisible.h"
#import "FlowLayoutAplhaZero.h"
#import "TransparentView.h"
#import "MakeAllInvisible.h"
#import "RBMenu.h"
#import "btSimplePopUP.h"
#import "UIColor+BFPaperColors.h"



/* attributes that define the snap damping*/
#define SNAP_UP_DAMPING_UPPER_THIRD   1.0f
#define SNAP_UP_DAMPING_MIDDLE_THIRD  1.0f
#define SNAP_UP_DAMPING_BOTTOM_THIRD  1.0f


/* attributes that define the snap down damping*/
#define SNAP_DOWN_DAMPING_UPPER_THIRD   1.0f
#define SNAP_DOWN_DAMPING_MIDDLE_THIRD  1.0f
#define SNAP_DOWN_DAMPING_BOTTOM_THIRD  1.0f

/* remove view annimation */
#define SNAP_REMOVE_SCREENS_DELAY      0.8f
#define SNAP_REMOVE_SCREENS_DURATION   0.2f

/* pinching boundery values */
#define PINCH_MIN_VAL  0.4f
#define PINCH_MAX_VAL  1.3f





@interface CollectionViewController ()
{
    CGRect _cellRelativeCoordinates;
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UIAttachmentBehavior* _attachement;
    UISnapBehavior * _snapper;
    UIAttachmentBehavior *_elasticityBehavior;
    UIImageView * _view;
    UIImageView * oldView;
    CVCell*   displayedCell;
 
    
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;



@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"user_normal"]
                                                selectedImage:[UIImage imageNamed:@"user_pressed"]];
             }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
   self =  [super initWithCoder:aDecoder];
    if(self)
    {
        
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"user_normal"]
                                                selectedImage:[UIImage imageNamed:@"user_pressed"]];
        
        
    }
    
    
    
    return self;
}

/*
  this was a fix for 
 
- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    [self.collection.collectionViewLayout invalidateLayout];
}
 */

/* Snap the view up into place for viewing. */
 
-(void) snapView:(UIView*) view point:(CGPoint) point
{
    _itemSelected=YES;
    
    
    if(_isTransitioning)
        return;
    _isTransitioning= YES;
    [self.view addSubview: view];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _snapper = [[UISnapBehavior alloc] initWithItem:view snapToPoint:point];
    
    if(view.frame.origin.y > SCREEN_HEIGHT/3)
    {
        _snapper.damping = SNAP_UP_DAMPING_UPPER_THIRD;
    }
    else
    {
        _snapper.damping = SNAP_UP_DAMPING_BOTTOM_THIRD;
        
    }
 
    
    UIDynamicItemBehavior * dynamicItem = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    dynamicItem.allowsRotation = NO;
    [_animator addBehavior:dynamicItem];
    [_animator addBehavior:_snapper];
 
     [self performSelector:@selector(transitioningFinished:) withObject:nil];
    
    
}

-(void) transitioningFinished:(id) arg
{
    //no longer transitioning so other operations can begin
    _isTransitioning = NO;
}



/* removes the cover images with animation*/
-(void) reset
{
    
    [UIView animateWithDuration:SNAP_REMOVE_SCREENS_DURATION
                          delay:SNAP_REMOVE_SCREENS_DELAY
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _view.alpha =0;
                         oldView.alpha=0;
                       _isTransitioning=NO;
                         
                      
                     }
                     completion:^(BOOL finished){

                          [_view removeFromSuperview];
                         [oldView removeFromSuperview];
                         _itemSelected=NO;
                         
                     }];
    
 
    
    
}



/* snap the view back to the original position */
-(void) snapBackView:(UIView*) view point:(CGPoint) point
{
    //item selected
    _itemSelected=NO;
    
    // if the item is already transitioning then do nothing
    if(_isTransitioning)
        return;
    
    // set transitioning variable
    _isTransitioning=YES;
    
    
    // add the transitioned view as a subview- required by the animators
    [self.view addSubview: view];
    
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _animator.delegate = self;
    _snapper = [[UISnapBehavior alloc] initWithItem:view snapToPoint:point];
    if(view.frame.origin.y > SCREEN_HEIGHT/3)
    {
        _snapper.damping = SNAP_DOWN_DAMPING_UPPER_THIRD;
    }
    else
    {
        _snapper.damping = SNAP_DOWN_DAMPING_MIDDLE_THIRD;
        
    }
   
    
    UIDynamicItemBehavior * dynamicItem = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    dynamicItem.allowsRotation = NO;
    [_animator addBehavior:dynamicItem];
    [_animator addBehavior:_snapper];
    
     [self performSelector:@selector(removeScreens:) withObject:nil];
     
}
                       
-(IBAction) removeScreens:(id) timer
{
    // remove screens with animation
    [self reset];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

    CVCell*   cell =  (CVCell*)  [_collection  cellForItemAtIndexPath:indexPath];
    
     // no item is currently selected so move an item to the top
    if(!_itemSelected)
    {
        displayedCell=cell;
    
        CGRect cellFrame = cell.frame;
    
        // store the coordinates of the selected view
        _cellRelativeCoordinates = [self.view convertRect:cellFrame fromView:self.collection];
    
    
        // snap imaage of the cell
        _view = [self addTakeImage:cell];
            cell.image.hidden=NO;
        
      // coordinates in self coordinates
      _view.frame=_cellRelativeCoordinates;
        
        
      // we don't actually snap the view but let the receiver of the message snap the view.
        
     // [self snapView:_view point:CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT/2+10)];
     //_itemSelected=YES;
        
        // create a dictionoary of attributes to send.
        NSDictionary * dict = @{
                                @"coordinates": NSStringFromCGRect(_cellRelativeCoordinates),
                                @"imageView":_view,
                                @"index":[NSNumber numberWithInteger:indexPath.row],
                                @"control":self,
                                @"color":cell.backgroundColor,
                                };
    
   // notify the owner of this control that the cell wants to transition up.
    NSNotification *notification = [NSNotification notificationWithName:MESSAGE_CELL_UP  object:self userInfo:dict];
        [[NSNotificationQueue defaultQueue]
         enqueueNotification:notification
         postingStyle:NSPostASAP];
        
 
        
    }
    else
    {
      // cell is already being displayed so notify the owner of the control it needs to be
      // transitioned down
        
        
        // create dictionary of information for the owner of the control
        NSDictionary * dict = @{
                                @"coordinates": NSStringFromCGRect(_cellRelativeCoordinates),
                                @"imageView":_view,
                                @"index":[NSNumber numberWithInteger:indexPath.row],
                                @"control":self,
                                };
        
        
        
        // notify the owner(s) of the control that the control wants to be transisioned down
        NSNotification *notification = [NSNotification notificationWithName:MESSAGE_CELL_DOWN object:self userInfo:dict];
        [[NSNotificationQueue defaultQueue]
         enqueueNotification:notification
         postingStyle:NSPostASAP];
        
        
       
        
    }

    
    
    
  /*
    if(!_itemSelected)
    {
        
   
        
        _contentOffset = [_collection contentOffset];
        
        NSArray * visibleCells = [_collection visibleCells];
        CVCell* cell;
        
        for (cell in visibleCells)
        {
            
            //cell.alpha = 0;
            
        }
        
        

        
        [UIView animateWithDuration:.2
                              delay:5.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                              // [_collection  setCollectionViewLayout: invisible animated:YES];
                      
                         }
                         completion:^ (BOOL finished){
                             
                             
                             [UIView animateWithDuration:.4
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  
                                                
                                                  
                                                // [_collection  setCollectionViewLayout: sfl animated:NO];
                                              }
                                              completion:nil];
                             
                             
                             
                                                          }];
        
        _itemSelected=YES;
        
    }
    else
    {
        
        MyFlowLayout *flowLayout = [[MyFlowLayout alloc] init];
        
        NSArray * visibleCells = [_collection visibleCells];
        
        CVCell * cell;
        
          [UIView animateWithDuration:.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                            
                             [self.collectionView setCollectionViewLayout:flowLayout animated:YES];
                             [_collection setContentOffset:_contentOffset];
                         }
                         completion:^ (BOOL finished){
                             
                             
                             [UIView animateWithDuration:.2
                                                   delay:3.0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  
                                              //  [_collection  setCollectionViewLayout: visible animated:YES];
                                                
                           
                                              }
                                              completion:nil];
                             
                             
                             
                         }];
       
        
        _itemSelected=NO;
        
    }
    
    
    */
    
    
   // NSLog(@"%s", __PRETTY_FUNCTION__);
}




/*  snap an picture of the view in arg 1 */
-(UIImageView*) addTakeImage:(UIView*) view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView* imageView = [[UIImageView alloc] initWithImage:img];
    return imageView;
    
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    
    /* Uncomment this block to use nib-based cells */
   // UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
   // [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    /* end of nib-based cells block */
    
    /* subclassed cell */
     [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    
    
 
    
    // Configure layout using MyFlowLayout
    MyFlowLayout *flowLayout = [[MyFlowLayout alloc] init];
    
    /// NB hard coded
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    _oldScale=-1;
    
    /* register for notification when its time to transition the view down*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeBlurImage:)
                                                 name:MESSAGE_DROP_DOWN_MENU_COMPLETE object:nil];
    
  
 
}


-(IBAction)removeBlurImage:(id)sender
{
    
    [self.backGroundBlurr removeFromSuperview];
    self.view.userInteractionEnabled = YES;
    
}


-(IBAction)handlePinch:(UIPinchGestureRecognizer*)sender
{

    
    _scale= sender.scale;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        _startScale=sender.scale;
        
    }
    else if ( sender.state == UIGestureRecognizerStateChanged)
    {
        
        
        // if is pinching smaler but the sacle is already .04 than do nothing
        // we don't want this any smaller
        // not really working but can return to this later.
        if(sender.scale/_startScale <= PINCH_MIN_VAL  && sender.velocity < 0)
        {
            return;
        }
        else if(sender.scale/_startScale >=PINCH_MAX_VAL && sender.velocity > 0 )
        {
            return;
        }
        
           MyFlowLayout *flowLayout =  (MyFlowLayout*) [[self collectionView] collectionViewLayout];
           [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT )];
        
        
        if(_oldScale == -1)
        {
            flowLayout.scaleValue = sender.scale/_startScale;
            
        }
        else
        {
            
           /* sender.scale -_startScale very interesting */
            flowLayout.scaleValue = sender.scale/_startScale;
        }
        
        
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
            [self.collectionView setCollectionViewLayout:flowLayout];
            [flowLayout invalidateLayout];
        
    }
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        
        
        _oldScale=sender.scale;
       
        
    }
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // NB not sure why this check is here
    /* 
     commend out should still work fine.
    if(scrollView.contentOffset.y <=5)
    {
        _myView.userInteractionEnabled = YES;
    }
     
     */
    
    /*
     comment out shoul work fine
    CGPoint scrollVelocity = [_collection.panGestureRecognizer velocityInView:_collection.superview];
    if (scrollVelocity.y > 0.0f)
        NSLog(@"going down");
    else if (scrollVelocity.y < 0.0f)
        NSLog(@"going up");
     */
    
  
}
- (IBAction)operationsClicked:(id)sender
{
    
    NSLog(@"operation clicked");
    
    _popUp = [[btSimplePopUP alloc]initWithItemImage:@[
                                                      [UIImage imageNamed:@"alert.png"],
                                                      [UIImage imageNamed:@"attach.png"],
                                                      [UIImage imageNamed:@"cloudUp.png"],
                                                      [UIImage imageNamed:@"facebook.png"],
                                                      [UIImage imageNamed:@"camera.png"],
                                                      [UIImage imageNamed:@"dropBox.png"],
                                                      [UIImage imageNamed:@"mic.png"],
                                                      [UIImage imageNamed:@"wi-Fi.png"],
                                                      [UIImage imageNamed:@"curved.png"],
                                                      [UIImage imageNamed:@"stacks.png"],
                                                      [UIImage imageNamed:@"share.png"],
                                                      [UIImage imageNamed:@"twitter.png"],
                                                      [UIImage imageNamed:@"search.png"],
                                                      [UIImage imageNamed:@"whatsApp.png"],
                                                      [UIImage imageNamed:@"settings.png"],
                                                      ]
                                          andTitles:    @[
                                                          @"Alert", @"Attach",@"Upload", @"Facebook", @"Camera", @"Dropbox",
                                                          @"Recording", @"Wi-Fi", @"Icon", @"Stacks", @"Share", @"Twitter", @"Search", @"WhatsApp", @"Settings"
                                                          ]
             
                                     andActionArray:@[
                                                      ^{
        
        __block UIViewController *temp = [[UIViewController alloc]init];
        temp.view.backgroundColor = [UIColor blueColor];
        [self.navigationController presentViewController:temp
                                                animated:YES
                                              completion:^{
                                                  
                                                  [temp dismissViewControllerAnimated:YES completion:nil];
                                              }];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    }]
                                addToViewController:self];
    
    [self.view addSubview:_popUp];
    [_popUp setPopUpStyle:BTPopUpStyleDefault];
    [_popUp setPopUpBorderStyle:BTPopUpBorderStyleDefaultNone];
    //    [popUp setPopUpBackgroundColor:[UIColor colorWithRed:0.1 green:0.2 blue:0.6 alpha:0.7]];
    
    [self showPopUP:nil];
    
}


-(void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"PopItem" message:@" iAM from Block" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)showPopUP:(id)sender {
    
     [_popUp setPopUpBackgroundColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.1 alpha:0.7]];
     [_popUp setPopUpStyle:BTPopUpStyleDefault];
     [_popUp setPopUpBorderStyle:BTPopUpBorderStyleDefaultNone];
     [_popUp show:BTPopUPAnimateNone];
}
- (IBAction)SelectView:(id)sender
{
    
    
    CGRect screenSize = [UIScreen mainScreen].bounds;
    // self.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
    UIImage *screenShot = [self.view   screenshot];
    UIImage *blurImage  = [screenShot blurredImageWithRadius:10.5 iterations:2 tintColor:nil];
    _backGroundBlurr = [[UIImageView alloc]initWithImage:blurImage];
    _backGroundBlurr.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
    _backGroundBlurr.alpha = 1;
    _backGroundBlurr.userInteractionEnabled=NO;
    self.view.userInteractionEnabled = NO;
    
    
    RBMenuItem *item = [[RBMenuItem alloc]initMenuItemWithTitle:@"All Years" withCompletionHandler:^(BOOL finished){
        
        
        
    }];
    RBMenuItem *item2 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Albums" withCompletionHandler:^(BOOL finished){}];
    RBMenuItem *item3 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Month" withCompletionHandler:^(BOOL finished){}];
    RBMenuItem *item4 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Make Recomendation" withCompletionHandler:^(BOOL finished){}];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    _menu = [[RBMenu alloc] initWithItems:@[item2, item3,item4] andTextAllignment:RBMenuTextAlignmentCenter forViewController:self];
    
    [_menu showMenu];
    
}


- (IBAction)buttonClicked:(id)sender
{
    
    CGRect screenSize = [UIScreen mainScreen].bounds;
   // self.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
    UIImage *screenShot = [self.view   screenshot];
    UIImage *blurImage  = [screenShot blurredImageWithRadius:10.5 iterations:2 tintColor:nil];
    _backGroundBlurr = [[UIImageView alloc]initWithImage:blurImage];
    _backGroundBlurr.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
    _backGroundBlurr.alpha = 1;
    _backGroundBlurr.userInteractionEnabled=NO;
    self.view.userInteractionEnabled = NO;
    
  
    
    [self.view  addSubview:_backGroundBlurr];
  
    
    
    RBMenuItem *item = [[RBMenuItem alloc]initMenuItemWithTitle:@"All Years" withCompletionHandler:^(BOOL finished){
        
  
        
    }];
    RBMenuItem *item2 = [[RBMenuItem alloc]initMenuItemWithTitle:@"1015" withCompletionHandler:^(BOOL finished){}];
     RBMenuItem *item3 = [[RBMenuItem alloc]initMenuItemWithTitle:@"2014" withCompletionHandler:^(BOOL finished){}];
     RBMenuItem *item4 = [[RBMenuItem alloc]initMenuItemWithTitle:@"2013" withCompletionHandler:^(BOOL finished){}];
     RBMenuItem *item5 = [[RBMenuItem alloc]initMenuItemWithTitle:@"2014" withCompletionHandler:^(BOOL finished){}];
     RBMenuItem *item6 = [[RBMenuItem alloc]initMenuItemWithTitle:@"2013" withCompletionHandler:^(BOOL finished){}];
     RBMenuItem *item7 = [[RBMenuItem alloc]initMenuItemWithTitle:@"2012" withCompletionHandler:^(BOOL finished){}];
     RBMenuItem *item8= [[RBMenuItem alloc]initMenuItemWithTitle:@"2011" withCompletionHandler:^(BOOL finished){}];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    _menu = [[RBMenu alloc] initWithItems:@[item, item2,item3,item4,item5,item6,item7,item8] andTextAllignment:RBMenuTextAlignmentCenter forViewController:self];
    
       [_menu showMenu];
    
    
 
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArray count];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
    
}

/* geneerate a random color. used for testing */
-(UIColor*) getColor
{
    // Generate a random color
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"cvCell";

    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    
       //get the title to the cell
       NSString *cellData = [data objectAtIndex:indexPath.row];
       UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
   // return the lable  for the title.
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    
    /* this is a test application */
    titleLabel.textColor = [self getColor] ;
    
    cell.backgroundColor = [UIColor paperColorLightBlue200];
    cell.alpha =1;
    cell.backgroundView.alpha =1;
   
    /* don't need. Font sent in xib file */
    // titleLabel.font = [UIFont fontWithName:@"Noteworthy Bold" size:15];
    
    /* set the title label */
    [titleLabel setText:cellData];
 
 
   // cell.tintColor=[self getColor];
    //cell.backgroundColor=[UIColor whiteColor];//[self getColor];
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
