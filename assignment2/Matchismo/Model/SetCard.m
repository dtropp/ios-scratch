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

- (id)initWithShape:(NSString *)shape
               count:(NSUInteger)count
               color:(NSString *)color
             shading:(NSString *)shading {
  self = [super init];
  
  if (self) {
    _shape = shape;
    _count = count;
    _color = color;
    _shading = shading;
  }
  return self;
}

- (NSString *)contents {
  NSArray* contents = @[self.shading, self.color, self.shape];
  return [NSString stringWithFormat:@"%d%@.", self.count, [contents componentsJoinedByString:@""]];
}

- (NSNumber*) countAsNSNumber {
  return [NSNumber numberWithInteger:self.count];
}

- (BOOL) all3DifferentOrSame:(NSArray*) items {
  BOOL allSame = [items[0] isEqual:items[1]] && [items[0] isEqual:items[2]];
  BOOL allDifferent = ![items[0] isEqual:items[1]] && ![items[0] isEqual:items[2]] && ![items[1] isEqual:items[2]];
  NSLog(@"all3DifferentOrSame:%@ same:%d diff:%d", [items componentsJoinedByString:@","], allSame, allDifferent);
  return allSame || allDifferent;
}

- (int)match:(NSArray *)otherCards {
  int score = 0;
  NSLog(@"match:%@", [otherCards componentsJoinedByString:@","]);
  if ([otherCards count] == 2) {
    if ([otherCards[0] isKindOfClass:[self class]] &&
        [otherCards[1] isKindOfClass:[self class]]) {
      SetCard* firstCard = (SetCard*)otherCards[0];
      SetCard* secondCard = (SetCard*)otherCards[1];
      if ([self all3DifferentOrSame:@[self.color, firstCard.color, secondCard.color]] &&
          [self all3DifferentOrSame:@[self.shading, firstCard.shading, secondCard.shading]] &&
          [self all3DifferentOrSame:@[self.shape, firstCard.shape, secondCard.shape]] &&
          [self all3DifferentOrSame:@[[self countAsNSNumber], [firstCard countAsNSNumber], [secondCard countAsNSNumber]]]) {
        score = 10;
      }
    }
  }
  return score;
}

@end
