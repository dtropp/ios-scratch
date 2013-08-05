//
//  SetCard.m
//  Matchismo2
//
//  Created by Dan Tropp on 31/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "SetCard.h"
@interface SetCard()

@end

@implementation SetCard

- (id)initWithSymbol:(NSString *)symbol
               count:(NSUInteger)count
               color:(NSString *)color
             shading:(NSString *)shading {
  self = [super init];
  
  if (self) {
    _symbol = symbol;
    _count = count;
    _color = color;
    _shading = shading;
  }
  return self;
}

- (NSString *)contents {
  NSArray* contents = @[self.shading, self.color, self.symbol];
  return [NSString stringWithFormat:@"%d%@.", self.count, [contents componentsJoinedByString:@""]];
}

@end
