//
//  SetGameViewController.m
//  Matchismo2
//
//  Created by Dan Tropp on 30/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)newDeck {
  return [[SetCardDeck alloc] init];
}

- (void)updateCard:(Card*) card onto:(UIButton*) cardButton {
  if ([card isKindOfClass:[SetCard class]]) {
    SetCard* setCard = (SetCard*) card;
    NSLog(@"SetCard: %@, %@, %@, %d", setCard.symbol, setCard.shading, setCard.color, setCard.count);
  }
}

@end
