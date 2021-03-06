//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "Deck.h"
#import "FlipResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (strong, nonatomic) NSAttributedString* lastAction;

- (void)updateCard:(Card*) card onto:(UIButton*) cardButton;

@end

@implementation CardGameViewController

- (Deck *)newDeck {
  return nil;
}

- (void)viewDidLoad {
  [self dealNewGame];
  NSLog(@"Got %d cards in outlet colletion", [self.cardButtons count]);
}

- (IBAction)dealNewGame {
  self.game = nil;
  self.flipsCount = 0;
  NSString* newGameAction = [NSString stringWithFormat:@"New game matching %d %@ cards!", self.game.cardsPerMatch, self.game.deckType];
  self.lastAction = [[NSAttributedString alloc] initWithString:newGameAction];
  [self updateUI];
}

- (void) setCardButtons:(NSArray *)cardButtons {
  _cardButtons = cardButtons;
}

- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    Card* card = [self.game cardAtIndex:[_cardButtons indexOfObject:cardButton]];
    cardButton.enabled = !card.isUnplayable;
    cardButton.selected = card.isFaceUp;
    [self updateCard:card onto:cardButton];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)updateCard:(Card*) card onto:(UIButton*) cardButton {
  if (card.isFaceUp) {
    NSLog(@"Card is face up: %@", card);
    //Normal config is used by all other states as default (ie. selected and disabled)
    [cardButton setImage:nil forState:UIControlStateNormal];
    [cardButton setTitle:card.contents forState:UIControlStateNormal];
  } else {
    NSLog(@"Card is face down: %@", card);
    [cardButton setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
    [cardButton setTitle:nil forState:UIControlStateNormal];
  }
  cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
}

- (NSUInteger) cardsPerMatch {
  return 2;
}

- (CardMatchingGame*) game {
  if (!_game) {
    NSLog(@"new game created");
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self newDeck]
                                          cardsPerMatch:[self cardsPerMatch]];
  }
  return _game;
}

- (void) setFlipsCount:(int)flipsCount {
  _flipsCount = flipsCount;
  self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}

- (void) setLastAction:(NSAttributedString *)lastAction {
  _lastAction = lastAction;
  self.lastActionLabel.attributedText = _lastAction;
}

- (NSAttributedString*) formatCards:(NSArray*)cards {
  return [[NSAttributedString alloc] initWithString:[cards componentsJoinedByString:@" & "]];
}

- (NSAttributedString*) flipMessage:(FlipResult*)flipResult {
  NSString* message;
  if (flipResult.isMatch)
  {
    message = @"Score! Matched ";
  } else if (flipResult.isMismatch) {
    message = @"Penalty! No match for ";
  } else { //Card flip only
    Card* card = flipResult.cards[0];
    message = [NSString stringWithFormat:@"Flipped %@ ", (card.isFaceUp ? @"up" : @"down")];
  }
  NSMutableAttributedString* messageWithCards = [[NSMutableAttributedString alloc] initWithString:message];
  [messageWithCards appendAttributedString:[self formatCards:flipResult.cards]];
  return messageWithCards;
}

- (IBAction)flipCard:(UIButton *)sender {
  NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
  FlipResult* result = [self.game flipCardAtIndex:cardIndex];
  self.lastAction = [self flipMessage:result];
  [self updateUI];
  self.flipsCount++;
}


@end
