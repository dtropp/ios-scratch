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
@property (nonatomic) NSUInteger cardsPerMatch;

@end

@implementation CardMatchingGame

- (id) initWithCardCount: (NSUInteger) cardCount
               usingDeck: (Deck*) deck
           cardsPerMatch:(NSUInteger) cardsPerMatch {
  self = [super init];
  if (self) {
    _cardsPerMatch = cardsPerMatch;
    _cards = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < cardCount; index++) {
      Card* card = [deck drawRandomCard];
      if (card) {
        [_cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
    _deckType = deck.typeOfCard;
  }
  return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (NSArray*) cardsAvailableToMatch {
  NSMutableArray* matchable = [[NSMutableArray alloc] init];
  for (Card* card in self.cards) {
    if (card.isFaceUp && !card.isUnplayable) [matchable addObject:card];
  }
  return matchable;
}

- (NSString*) flipCardAtIndex: (NSUInteger) index {
  Card* card = [self cardAtIndex:index];
  NSString* actionMessage = nil;
  
  if (!card.isUnplayable) {
    if (!card.isFaceUp) {
      NSArray* matchableCards = [self cardsAvailableToMatch];
      if ( ([matchableCards count]+1) == self.cardsPerMatch) {
        int matchScore = [card match:matchableCards];
        int flipScore = 0;
        if (matchScore) {
          for (Card* otherCard in matchableCards) {
            otherCard.unplayable = YES;
          }
          card.unplayable = YES;
          flipScore = matchScore * MATCH_BONUS;
          actionMessage = [NSString stringWithFormat:@"Matched %@ for %d points!",
                           [[card class] stringFromCards:[@[card] arrayByAddingObjectsFromArray:matchableCards]],
                           flipScore];
        } else {
          for (Card* otherCard in matchableCards) {
            otherCard.faceUp = NO;
          }
          flipScore = -(MISMATCH_PENALTY);
          actionMessage = [NSString stringWithFormat:@"No match for %@ & %@! Penalty of %d points!",
                           card.contents,
                           [matchableCards componentsJoinedByString:@" & "],
                           flipScore];
        }
        self.score += flipScore;
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


@end
