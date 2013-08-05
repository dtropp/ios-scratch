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

- (UIColor*) colorForColorName:(NSString*) colorName {
  NSDictionary* colorMap = @{@"red":[UIColor redColor],
                             @"green":[UIColor greenColor],
                             @"purple":[UIColor purpleColor]};
  return [colorMap valueForKey:colorName];
}

- (float) alphaForShading:(NSString*) shadingName {

  NSDictionary* alphaMap = @{@"solid":@1.0,
                             @"striped":@0.5,
                             @"open":@1.0};
  float alpha = [[alphaMap valueForKey:shadingName] floatValue];
  NSLog(@"Alpha is %0.1f", alpha);
  return alpha;
}

- (Deck *)newDeck {
  return [[SetCardDeck alloc] init];
}

- (void)updateCard:(Card*) card onto:(UIButton*) cardButton {
  if ([card isKindOfClass:[SetCard class]]) {
    SetCard* setCard = (SetCard*) card;
    NSLog(@"SetCard: %@, %@, %@", setCard.symbols, setCard.shading, setCard.color);
    [cardButton setImage:nil forState:UIControlStateNormal];
    NSMutableDictionary* stringAttributes = [[NSMutableDictionary alloc] init];
    [stringAttributes setObject:[self colorForColorName:setCard.color] forKey:NSForegroundColorAttributeName];
    NSArray* fonts = [UIFont familyNames];
    NSLog(@"%@", fonts);
//    UIFont* font = [UIFont fontWithName: size:20.0];
//    [stringAttributes setObject:font forKey:NSFontAttributeName];
    
    
    
    NSAttributedString* title = [[NSAttributedString alloc]
                                 initWithString:setCard.symbols
                                 attributes:stringAttributes];
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
    cardButton.alpha = [self alphaForShading:setCard.shading];
    
    if (card.isFaceUp) {
      NSLog(@"Card is face up: %@", card);
      //Normal config is used by all other states as default (ie. selected and disabled)
      [cardButton setBackgroundColor:[UIColor lightGrayColor]];
    } else {
      NSLog(@"Card is face down: %@", card);
      [cardButton setBackgroundColor:[UIColor whiteColor]];
    }
    cardButton.hidden = card.isUnplayable;

  }
}

@end
