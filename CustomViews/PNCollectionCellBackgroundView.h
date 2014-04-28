//
//  PNCollectionCellBackgroundView.h
//
//  Created by Jay Slupesky on 10/3/12.
//

#import <UIKit/UIKit.h>

@interface PNCollectionCellBackgroundView : UIView

void addRoundedRect(CGContextRef ctx, CGRect rect, float cornerRadius);

@end
