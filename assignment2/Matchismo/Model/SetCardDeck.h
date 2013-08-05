//
//  SetCardDeck.h
//  Matchismo2
//
//  Created by Dan Tropp on 1/08/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "Deck.h"

// The deck consists of 81 cards varying in four features:
// number (one, two, or three);
// symbol (diamond, squiggle, oval);
// shading (solid, striped, or open); and
// color (red, green, or purple)

// Several games can be played with these cards, all involving the concept of a set. A set consists of three cards which satisfy all of these conditions:
// They all have the same number, or they have three different numbers.
// They all have the same symbol, or they have three different symbols.
// They all have the same shading, or they have three different shadings.
// They all have the same color, or they have three different colors.
// The rules of Set are summarized by: If you can sort a group of three cards into "Two of ____ and one of _____," then it is not a set.

@interface SetCardDeck : Deck

+ (NSArray*) validShapes;

@end
