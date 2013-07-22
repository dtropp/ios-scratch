//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Dan Tropp on 22/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray* cards;
@property (nonatomic, readwrite) int score;

@end

@implementation CardMatchingGame

- (id) initWithCardCount: (NSUInteger) cardCount
               usingDeck: (Deck*) deck {
  self = [super init];
  if (self) {
    for (NSUInteger index = 0; index < cardCount; index++) {
      Card* card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (NSString*) flipCardAtIndex: (NSUInteger) index {
  Card* card = [self cardAtIndex:index];
  NSString* actionMessage = nil;
  
  if (!card.isUnplayable) {
    if (!card.isFaceUp) {
      for (Card* otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
          int matchScore = [otherCard match:@[card]];
          int flipScore = 0;
          if (matchScore) {
            otherCard.unplayable = YES;
            card.unplayable = YES;
            flipScore = matchScore * MATCH_BONUS;
            actionMessage = [NSString stringWithFormat:@"Matched %@ & %@ for %d points!", card.contents, otherCard.contents, flipScore];
          } else {
            otherCard.faceUp = NO;
            flipScore = -(MISMATCH_PENALTY);
            actionMessage = [NSString stringWithFormat:@"No match for %@ & %@! Penalty of %d points!", card.contents, otherCard.contents, flipScore];
          }

          self.score += flipScore;
        }
      }
      self.score -= FLIP_COST;
      if (!actionMessage) {
        actionMessage = [NSString stringWithFormat:@"Turned %@ up.", card.contents];
      }
    }
    else {
      actionMessage = [NSString stringWithFormat:@"Turned %@ back down.", card.contents];
    }
    card.faceUp = !card.isFaceUp;
  }
  
  return actionMessage;
}


- (Card*) cardAtIndex: (NSUInteger) index {
  return index < self.cards.count ? self.cards[index] :  nil;
}



- (NSMutableArray*) cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}


@end
