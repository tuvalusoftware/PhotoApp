/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  A collection view cell that displays a thumbnail image.
  
 */

#import "GridViewCell.h"

@interface GridViewCell ()
@property (strong) IBOutlet UIImageView *imageView;
@end

@implementation GridViewCell

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    _thumbnailImage = thumbnailImage;
    self.imageView.image = thumbnailImage;
}

@end
