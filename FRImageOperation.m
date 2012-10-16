// Copyright (c) 2011 Jonathan Dalrymple
// 
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
//  FRImageOperation.m
//
//  Created by Jonathan Dalrymple
//  Copyright 2011 Jonathan Dalrymple. All rights reserved.
//

#import "FRImageOperation.h"

@implementation FRImageOperation

@synthesize canvasSize = canvasSize_;

#pragma mark - Object life cycle
- (id) init{
	
	if( !(self = [super init]) ) return nil;

	[self setCanvasSize:CGSizeZero];

	return self;
}

- (id) initWithSize:(CGSize) aSize{
	
	if( !(self = [self init]) ) return nil;
	
	[self setCanvasSize:aSize];
	
	return self;
}

- (void) dealloc {
    
    [super dealloc];
}

#pragma mark - Methods to be overridden
/**
 *	This method is to overridden by subclasses
 */
- (void) renderInContext:(CGContextRef) aContext{
	//Go forth and draw!!
}

#pragma mark - boilerplate

- (void) main{
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//////////////////////////////////////////
	
	CGContextRef		context;
	void				*bitmapData;
	CGColorSpaceRef		colorSpace;
	int					bitmapByteCount;
	int					bitmapBytesPerRow;
	
	//
	bitmapBytesPerRow	= ([self canvasSize].width * 4);
	bitmapByteCount		= (bitmapBytesPerRow * [self canvasSize].height);
	
	//Create the color space
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	bitmapData = malloc( bitmapByteCount );
	
	//Check the the buffer is alloc'd
	if( bitmapData == NULL ){
		NSLog(@"Buffer could not be alloc'd");
	}
	
	//Create the context
	context = CGBitmapContextCreate(bitmapData, [self canvasSize].width, [self canvasSize].height, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
	
	if( context == NULL ){
		NSLog(@"Context could not be created");
	}
	
	//Render user data	
	[self renderInContext:context];
	
	//The contents of the context could be saved out as follows
	//Get the result image
	// resultImage = CGBitmapContextCreateImage(context);
	// 
	// //Save the image to the photos album
	// UIImageWriteToSavedPhotosAlbum( [UIImage imageWithCGImage:resultImage],self,@selector(image:error:context:),NULL);
	// 
	// CGImageRelease(resultImage);
	
	//Cleanup
	free(bitmapData);
	CGColorSpaceRelease(colorSpace);
		
	//////////////////////////////////////////
	[pool drain];
	
}

@end
