//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck*) newDeck;
- (NSAttributedString*) formatCards:(NSArray*)cards;
- (NSUInteger) cardsPerMatch;
- (void)updateCard:(Card*) card onto:(UIButton*) cardButton;

//Q Can you have abstract super classes?
//Q Should you put overriden methods in the public interface?

@end
