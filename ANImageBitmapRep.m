//
//  ANImageBitmapRep.m
//  ImageManip
//
//  Created by Alex Nichol on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANImageBitmapRep.h"

BMPixel BMPixelMake (CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
	BMPixel pixel;
	pixel.red = red;
	pixel.green = green;
	pixel.blue = blue;
	pixel.alpha = alpha;
	return pixel;
}

UIColor * UIColorFromBMPixel (BMPixel pixel) {
	return [UIColor colorWithRed:pixel.red green:pixel.green blue:pixel.blue alpha:pixel.alpha];
}

@implementation ANImageBitmapRep

+ (ANImageBitmapRep *)imageBitmapRepWithCGSize:(CGSize)avgSize {
	return [[[ANImageBitmapRep alloc] initWithSize:BMPointMake(round(avgSize.width), round(avgSize.height))] autorelease];
}

+ (ANImageBitmapRep *)imageBitmapRepWithImage:(UIImage *)anImage {
	return [[[ANImageBitmapRep alloc] initWithImage:anImage] autorelease];
}

- (void)invertColors {
	UInt8 pixel[4];
	BMPoint size = [self bitmapSize];
	for (long y = 0; y < size.y; y++) {
		for (long x = 0; x < size.x; x++) {
			[self getRawPixel:pixel atPoint:BMPointMake(x, y)];
			pixel[0] = 255 - pixel[0];
			pixel[1] = 255 - pixel[1];
			pixel[2] = 255 - pixel[2];
			[self setRawPixel:pixel atPoint:BMPointMake(x, y)];
		}
	}
}

- (void)setBrightness:(CGFloat)brightness {
	NSAssert(brightness >= 0 && brightness <= 2, @"Brightness must be between 0 and 2.");
	BMPoint size = [self bitmapSize];
	for (long y = 0; y < size.y; y++) {
		for (long x = 0; x < size.x; x++) {
			BMPoint point = BMPointMake(x, y);
			BMPixel pixel = [self getPixelAtPoint:point];
			pixel.red *= brightness;
			pixel.green *= brightness;
			pixel.blue *= brightness;
			if (pixel.red > 1) pixel.red = 1;
			if (pixel.green > 1) pixel.green = 1;
			if (pixel.blue > 1) pixel.blue = 1;
			[self setPixel:pixel atPoint:point];
		}
	}
}

- (BMPixel)getPixelAtPoint:(BMPoint)point {
	UInt8 rawPixel[4];
	[self getRawPixel:rawPixel atPoint:point];
	BMPixel pixel;
	pixel.alpha = (CGFloat)(rawPixel[3]) / 255.0;
	pixel.red = ((CGFloat)(rawPixel[0]) / 255.0) / pixel.alpha;
	pixel.green = ((CGFloat)(rawPixel[1]) / 255.0) / pixel.alpha;
	pixel.blue = ((CGFloat)(rawPixel[2]) / 255.0) / pixel.alpha;
	return pixel;
}

- (void)setPixel:(BMPixel)pixel atPoint:(BMPoint)point {
	NSAssert(pixel.red >= 0 && pixel.red <= 1, @"Pixel color must range from 0 to 1.");
	NSAssert(pixel.green >= 0 && pixel.green <= 1, @"Pixel color must range from 0 to 1.");
	NSAssert(pixel.blue >= 0 && pixel.blue <= 1, @"Pixel color must range from 0 to 1.");
	NSAssert(pixel.alpha >= 0 && pixel.alpha <= 1, @"Pixel color must range from 0 to 1.");
	UInt8 rawPixel[4];
	rawPixel[0] = round(pixel.red * 255.0 * pixel.alpha);
	rawPixel[1] = round(pixel.green * 255.0 * pixel.alpha);
	rawPixel[2] = round(pixel.blue * 255.0 * pixel.alpha);
	rawPixel[3] = round(pixel.alpha * 255.0);
	[self setRawPixel:rawPixel atPoint:point];
}

- (UIImage *)image {
	return [[[UIImage alloc] initWithCGImage:[self CGImage]] autorelease];
}

@end
