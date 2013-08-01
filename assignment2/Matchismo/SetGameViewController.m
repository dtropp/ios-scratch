//
//  SetGameViewController.m
//  Matchismo2
//
//  Created by Dan Tropp on 30/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)newDeck {
  return [[SetCardDeck alloc] init];
}


@end
