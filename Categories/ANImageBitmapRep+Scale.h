//
//  ScalableBitmapRep.h
//  ImageManip
//
//  Created by Alex Nichol on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANImageBitmapRep.h"


@interface ANImageBitmapRep (Scalable)

/**
 * Stretches the bitmap context to a specified size.
 * @param aSize The new size to make the bitmap.
 * If this is the same as the current size, the bitmap
 * will not be changed.
 */
- (void)setSize:(BMPoint)aSize;

/**
 * Scales the image down, then back up again.  Use this to blur an image.
 * @param quality A percentage from 0 to 1, 0 being horrible quality, 1 being
 * perfect quality.
 */
- (void)setQuality:(CGFloat)quality;

/**
 * Scales the image to fit a particular frame without stretching (bringing out of scale).
 * @param aSize The size to which the image scaled.
 * @discussion The actual image itself will most likely be smaller than the specified
 * size, leaving transparent edges to make the image fit the exact size.
 */
- (void)setSizeFittingFrame:(BMPoint)aSize;

/**
 * Scales the image to fill a particular frame without stretching.
 * This will most likely cause the left and right or top and bottom
 * edges of the image to be cut off.
 * @param aSize The size that the image will be forced to fill.
 */
- (void)setSizeFillingFrame:(BMPoint)aSize;

@end
