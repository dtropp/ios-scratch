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

- (NSString*) shapeForShape: (NSString*)shape shaded:(NSString*) shading {
  if ([shading isEqualToString:@"open"]) {
    NSDictionary* openSymbols =  @{@"▲":@"△",@"●":@"○",@"■":@"□"};
    return [openSymbols objectForKey:shape];
  } else {
    return shape;
  }
}

- (NSString*) cardShapes:(SetCard*) card {
  NSMutableString* shapes = [NSMutableString stringWithCapacity:0];
  NSString* shadedShape = [self shapeForShape:card.shape shaded:card.shading];
  for (int i=1; i <= card.count; i++) {
    [shapes appendString:shadedShape];
  }
  return shapes;
}

- (UIColor*) colorForColorName:(NSString*) colorName shaded:(NSString*)shading {
  NSDictionary* colorMap = @{@"red":[UIColor redColor],
                             @"green":[UIColor greenColor],
                             @"purple":[UIColor purpleColor]};
  return [[colorMap valueForKey:colorName] colorWithAlphaComponent:[self alphaForShading:shading]];
}

- (float) alphaForShading:(NSString*) shadingName {

  NSDictionary* alphaMap = @{@"solid":@1.0,
                             @"striped":@0.3,
                             @"open":@1.0};
  float alpha = [[alphaMap valueForKey:shadingName] floatValue];
//  NSLog(@"Alpha is %0.1f", alpha);
  return alpha;
}

- (Deck *)newDeck {
  return [[SetCardDeck alloc] init];
}

- (NSUInteger) cardsPerMatch {
  return 3;
}

- (NSAttributedString*) formatCards:(NSArray*)cards {
  NSMutableAttributedString* cardString = [[NSMutableAttributedString alloc] init];
  NSAttributedString* joiner = [[NSAttributedString alloc] initWithString:@" & "];
  for (SetCard* setCard in cards) {
    [cardString appendAttributedString:[self formatCard:setCard]];
    if (setCard != [cards lastObject]) {
      [cardString appendAttributedString:joiner];
    }
  }
  return cardString;
}

- (NSAttributedString*) formatCard:(SetCard*) setCard {
  NSMutableDictionary* stringAttributes = [[NSMutableDictionary alloc] init];
  [stringAttributes setObject:[self colorForColorName:setCard.color shaded:setCard.shading] forKey:NSForegroundColorAttributeName];
  
  return [[NSAttributedString alloc] initWithString:[self cardShapes:setCard]
                                         attributes:stringAttributes];
}

- (void)updateCard:(Card*) card onto:(UIButton*) cardButton {
  if ([card isKindOfClass:[SetCard class]]) {
    SetCard* setCard = (SetCard*) card;
    [cardButton setImage:nil forState:UIControlStateNormal];
    
    [cardButton setAttributedTitle:[self formatCard:setCard] forState:UIControlStateNormal];
    
    if (card.isFaceUp) {
      //Normal config is used by all other states as default (ie. selected and disabled)
      [cardButton setBackgroundColor:[UIColor lightGrayColor]];
    } else {
      [cardButton setBackgroundColor:[UIColor whiteColor]];
    }
    cardButton.hidden = card.isUnplayable;

  }
}

@end
