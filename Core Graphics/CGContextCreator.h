//
//  CGContextCreator.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class has several static functions for creating bitmap contexts.
 * These methods are pretty much only called when creating a new
 * ANImageBitmapRep.
 */

CGContextRef ARGBBitmapContextWithSizeCreate(CGSize size);
CGContextRef ARGBBitmapContextWithImageCreate(CGImageRef image);

__attribute__((deprecated("No need for class to do this, use functions instead")))
@interface CGContextCreator : NSObject {
   
}
+ (CGContextRef)newARGBBitmapContextWithSize:(CGSize)size __attribute__((deprecated));
+ (CGContextRef)newARGBBitmapContextWithImage:(CGImageRef)image __attribute__((deprecated));

@end