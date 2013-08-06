//
//  Deck.h
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard: (Card*)card atTop:(BOOL)atTop;
- (Card*)drawRandomCard;
- (NSString*)typeOfCard;
@end
