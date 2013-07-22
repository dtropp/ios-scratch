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

- (void) flipCardAtIndex: (NSUInteger) index {
  Card* card = [self cardAtIndex:index];
  
  if (!card.isUnplayable) {
    if (!card.isFaceUp) {
      for (Card* otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
          int score = [otherCard match:@[card]];
          if (score) {
            otherCard.unplayable = YES;
            card.unplayable = YES;
            self.score += score * MATCH_BONUS;
          } else {
            otherCard.faceUp = NO;
            self.score -= MISMATCH_PENALTY;
          }
        }
      }
      self.score -= FLIP_COST;
    }
    card.faceUp = !card.isFaceUp;
  }
}


- (Card*) cardAtIndex: (NSUInteger) index {
  return index < self.cards.count ? self.cards[index] :  nil;
}



- (NSMutableArray*) cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}


@end
