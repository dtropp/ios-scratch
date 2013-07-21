//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameViewController

- (Deck*) deck {
  if (!_deck) _deck = [[PlayingCardDeck alloc] init];
  return _deck;
}

- (void) setFlipsCount:(int)flipsCount {
  _flipsCount = flipsCount;
  self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}

- (IBAction)flipCard:(UIButton *)sender {
  if (!sender.selected) {
    [sender setTitle:[[self.deck drawRandomCard] contents] forState:UIControlStateSelected];
  }
  sender.selected = !sender.isSelected;
  self.flipsCount++;
}


@end
