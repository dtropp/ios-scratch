//
//  MatchResult.m
//  Matchismo2
//
//  Created by Dan Tropp on 9/08/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "FlipResult.h"

@implementation FlipResult

- (BOOL) isMatch {
  return self.score > 0;
}

- (BOOL) isMismatch {
  return self.score < 0;
}

- (id) initWithCard:(Card*)card {
  self = [self init];
  if (self) {
    _cards = [[NSMutableArray alloc] init];
    [_cards addObject:card];
  }
  return self;
}

@end
