//
//  ScalableBitmapRep.m
//  ImageManip
//
//  Created by Alex Nichol on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANImageBitmapRep+Scale.h"


@implementation ANImageBitmapRep(Scalable)

- (void)setSize:(BMPoint)aSize {
	CGContextRef newContext = ARGBBitmapContextCreateWithSize(CGSizeMake(aSize.x, aSize.y));
	CGImageRef image = [self CGImage];
	CGContextDrawImage(newContext, CGRectMake(0, 0, aSize.x, aSize.y), image);
	[self setContext:newContext];
	CGContextRelease(newContext);
}

- (void)setQuality:(CGFloat)quality {
	NSAssert(quality >= 0 && quality <= 1, @"Quality must be between 0 and 1.");
	if (quality == 1.0) return;
	CGSize cSize = CGSizeMake((CGFloat)([self bitmapSize].x) * quality, (CGFloat)([self bitmapSize].y) * quality);
	BMPoint oldSize = [self bitmapSize];
	[self setSize:BMPointMake(round(cSize.width), round(cSize.height))];
	[self setSize:oldSize];
}

- (void)setSizeFittingFrame:(BMPoint)aSize {
	CGSize oldSize = CGSizeMake([self bitmapSize].x, [self bitmapSize].y);
	CGSize newSize = CGSizeMake(aSize.x, aSize.y);
	
	float wratio = newSize.width / oldSize.width;
	float hratio = newSize.height / oldSize.height;
	float scaleRatio;
	if (wratio < hratio) {
		scaleRatio = wratio;
	} else {
		scaleRatio = hratio;
	}
	scaleRatio = scaleRatio;
	
	CGSize newContentSize = CGSizeMake(oldSize.width * scaleRatio, oldSize.height * scaleRatio);
	CGImageRef image = [self CGImage];
	CGContextRef newContext = ARGBBitmapContextCreateWithSize(CGSizeMake(aSize.x, aSize.y));
	CGContextDrawImage(newContext, CGRectMake(newSize.width / 2 - (newContentSize.width / 2),
											  newSize.height / 2 - (newContentSize.height / 2),
											  newSize.width, newContentSize.height), image);
	[self setContext:newContext];
	CGContextRelease(newContext);
}

- (void)setSizeFillingFrame:(BMPoint)aSize {
	CGSize oldSize = CGSizeMake([self bitmapSize].x, [self bitmapSize].y);
	CGSize newSize = CGSizeMake(aSize.x, aSize.y);
	
	float wratio = newSize.width / oldSize.width;
	float hratio = newSize.height / oldSize.height;
	float scaleRatio;
	if (wratio > hratio) { // only difference from -setSizeFittingFrame:
		scaleRatio = wratio;
	} else {
		scaleRatio = hratio;
	}
	scaleRatio = scaleRatio;
	
	CGSize newContentSize = CGSizeMake(oldSize.width * scaleRatio, oldSize.height * scaleRatio);
	CGImageRef image = [self CGImage];
	CGContextRef newContext = ARGBBitmapContextCreateWithSize(CGSizeMake(aSize.x, aSize.y));
	CGContextDrawImage(newContext, CGRectMake(newSize.width / 2 - (newContentSize.width / 2),
											  newSize.height / 2 - (newContentSize.height / 2),
											  newSize.width, newContentSize.height), image);
	[self setContext:newContext];
	CGContextRelease(newContext);
}

@end
