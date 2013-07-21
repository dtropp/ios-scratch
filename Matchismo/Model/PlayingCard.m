//
//  PlayingCard.m
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

- (NSString*) contents {
  return [[PlayingCard rankStrings][self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit;
- (void) setSuit:(NSString *)suit {
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString*) suit {
  return _suit ? _suit : @"?";
}

+ (NSArray*) validSuits {
  static NSArray* suits = nil;
  if (!suits) suits = @[@"♥", @"♦", @"♠", @"♣"];
  return suits;
}

+ (NSUInteger) maxRank {
  return [[PlayingCard rankStrings] count] - 1;
}
          
+ (NSArray*) rankStrings {
  static NSArray* rankStrings;
  if (!rankStrings) rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
  return rankStrings;
}

@end
