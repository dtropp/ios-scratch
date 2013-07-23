//
//  Card.m
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match: (NSArray*)otherCards {
  int score = 0;
  for (Card *otherCard in otherCards) {
    if ([self.contents isEqualToString:otherCard.contents]) {
      score = 1;
    }
  }
  
  return score;
}

- (NSString *)description {
  return self.contents;
}

@end
