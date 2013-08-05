//
//  SetCard.m
//  Matchismo2
//
//  Created by Dan Tropp on 31/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "SetCard.h"
@interface SetCard()

@property (strong, nonatomic) NSString* symbol;
@property (nonatomic) NSUInteger count;


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

- (NSString*) symbols {
  NSMutableString* symbols = [NSMutableString stringWithCapacity:0];
  for (int i=1; i <= self.count; i++) {
    [symbols appendString:self.symbol];
  }
  return symbols;
}

@end
