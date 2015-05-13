//
//  ViewController.h
//  CustomViews
//
//  Created by TouchROI on 2/27/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UITableView *table;
@property (retain) NSIndexPath* selectedIndexPath;
 

@end
