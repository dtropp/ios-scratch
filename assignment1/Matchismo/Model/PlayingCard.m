//
//  PlayingCard.m
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

- (int) match: (NSArray*)otherCards {
  int score = 0;
  //Match other cards to this card
  if (otherCards.count == 1 || otherCards.count == 2) {
    for (PlayingCard* otherCard in otherCards) {
      if ([otherCard.suit isEqualToString:self.suit]) score += 2;
      if (otherCard.rank == self.rank) score += 6;
    }
  }
  //Match other cards to each other
  if (otherCards.count == 2) {
    if ([[otherCards[0] suit] isEqualToString:[otherCards[1] suit]]) score += 2;
    if ([otherCards[0] rank] == [otherCards[1] rank]) score += 6;
  }

  NSLog(@"Score is %d / %d = %d", score, otherCards.count, (score / otherCards.count));
  return score / otherCards.count;
}

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
  return _suit ?: @"?";
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
