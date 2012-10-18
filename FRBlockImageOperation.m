//
//  FRBlockImageOperation.m
//  dataviewer
//
//  Created by Jonathan Dalrymple on 16/10/2012.
//  Copyright (c) 2012 Hello. All rights reserved.
//

#import "FRBlockImageOperation.h"

@interface FRBlockImageOperation ()

@property (nonatomic,strong) FRBlockImageOperationBlock executionBlock;

@end

@implementation FRBlockImageOperation

- (id)initWithSize:(CGSize)canvasSize block:(FRBlockImageOperationBlock) aBlock{
  
  self = [super initWithSize:canvasSize];
  if (self) {
    [self setExecutionBlock:aBlock];
  }
  return self;
}

- (void)renderInContext:(CGContextRef) aContext {
  
  if ([self executionBlock]) {
    [self executionBlock](aContext);
  }

}

@end
