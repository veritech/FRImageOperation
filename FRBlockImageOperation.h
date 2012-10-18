//
//  FRBlockImageOperation.h
//  dataviewer
//
//  Created by Jonathan Dalrymple on 16/10/2012.
//  Copyright (c) 2012 Hello. All rights reserved.
//

#import "FRImageOperation.h"

typedef void(^FRBlockImageOperationBlock)(CGContextRef context);

@interface FRBlockImageOperation : FRImageOperation

- (id)initWithSize:(CGSize)canvasSize block:(FRBlockImageOperationBlock) aBlock;

@end
