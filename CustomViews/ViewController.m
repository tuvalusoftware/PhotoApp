//
//  ViewController.m
//  CustomViews
//
//  Created by TouchROI on 2/27/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "ViewController.h"
#import "ExpandingCell.h"
#import <QuartzCore/QuartzCore.h>
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()

@end



NSString *kMyCellID = @"cellID";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   // [self.table  registerNib:[UINib nibWithNibName:@"ExpandingCell" bundle:nil] forCellReuseIdentifier:kMyCellID];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    // Return the number of rows in the section.
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyCellID forIndexPath:indexPath];

    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"cell number %i", indexPath.row];
  /*
    // set the radius
    CGFloat radius = 7.0;
    // set the mask frame, and increase the height by the
    // corner radius to hide bottom corners
    CGRect maskFrame = self.view.bounds;
    maskFrame.size.height += radius;
    // create the mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.cornerRadius = radius;
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    maskLayer.frame = maskFrame;
    maskLayer.borderWidth =10;
    maskLayer.borderColor = [UIColor blueColor].CGColor;
    
    
    // set the mask
    cell.layer.mask = maskLayer;
   */
    
    // Add a backaground color just to check if it works
    cell.backgroundColor = [UIColor whiteColor];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //check if the index actually exists
    if(_selectedIndexPath && indexPath.row == _selectedIndexPath.row) {
        return 480;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpandingCell *cell =(ExpandingCell*)   [self.table cellForRowAtIndexPath:indexPath];
    
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, cell.opaque, 0.0);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:img];
    imageView.frame = CGRectMake(320 , 0, 320 , cell.frame.size.height);
    
    
    CGRect cellFrame = cell.frame;
    CGRect cellRelativeCoordinates = [self.view convertRect:cellFrame fromView:self.table];
    imageView.frame = cellRelativeCoordinates;
    [self.view addSubview:imageView];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(cellRelativeCoordinates.origin.x, cellRelativeCoordinates.origin.y,cellRelativeCoordinates.size.width, cellRelativeCoordinates.size.height)];
    
      UIImageView * imageView2 = [[UIImageView alloc] initWithImage:img];
    
    imageView2.frame = CGRectMake(0,0,320, cell.frame.size.height);
    [view addSubview:imageView2];
   // view.backgroundColor = [UIColor grayColor];
    
    
  
    [self.view addSubview:view];
    
 
    
    
    [UIView animateWithDuration:1 animations:^{
        
        
        view.frame = CGRectMake(0,60, 320, 400);
        
       _table.contentOffset = CGPointMake(0, -200);
        
        
        
      //  imageView.frame = CGRectMake(0,60,320,frame.size.height);
       // CGAffineTransform  xform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-100));
       // imageView.transform = xform;
       
    }];
    
    
    
   // _selectedIndexPath = indexPath;
    //[tableView beginUpdates];
    //[tableView endUpdates];
    
    NSLog(@"help find the answer %@", cell.textLabel.text);
}


static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+(UIImage *)makeRoundCornerImage : (UIImage*) img : (int) cornerWidth : (int) cornerHeight
{
    int w = img.size.width;
    int h = img.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    addRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
  
    
    return [UIImage imageWithCGImage:imageMasked];
}

@end
