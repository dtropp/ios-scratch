//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Dan Tropp on 22/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id) initWithCardCount: (NSUInteger) cardCount
               usingDeck: (Deck*) deck
           cardsPerMatch:(NSUInteger) cardsPerMatch;

- (NSString*) flipCardAtIndex: (NSUInteger) index;

- (Card*) cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) NSString* deckType;
@property (nonatomic, readonly) NSUInteger cardsPerMatch;
@property (nonatomic, readonly) int score;

@end
