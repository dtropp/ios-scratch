//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dan Tropp on 18/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (strong, nonatomic) NSString* lastAction;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@property (nonatomic) NSUInteger gameType;
@property (strong, nonatomic) NSMutableArray *actionHistory;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;

@end

@implementation CardGameViewController
- (IBAction)slideThroughHistory:(UISlider *)sender {
  int index = ([self.actionHistory count] - 1) * sender.value;
  self.lastActionLabel.alpha = 0.5;
  self.lastActionLabel.text = self.actionHistory[index];
}

- (void)viewDidLoad {
  [self dealNewGame];
}

- (IBAction)gameTypeChosen:(UISegmentedControl *)sender {
  self.gameType = [[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] integerValue];
}

- (IBAction)dealNewGame {
  self.game = nil;
  self.flipsCount = 0;
  self.lastAction = [NSString stringWithFormat:@"New game matching %d cards!", self.gameType];
  self.gameTypeControl.enabled = YES;
  [self updateUI];
}

- (NSMutableArray*) actionHistory {
  if (!_actionHistory) _actionHistory = [[NSMutableArray alloc] init];
  return _actionHistory;
}

- (void) setGameType:(NSUInteger)gameType {
  if (gameType == 2 || gameType == 3) {
    _gameType = gameType;
    [self dealNewGame];
  }
}

- (void) setGameTypeControl:(UISegmentedControl *)gameTypeControl {
  _gameTypeControl = gameTypeControl;
  [self gameTypeChosen:self.gameTypeControl];
}

- (void) setCardButtons:(NSArray *)cardButtons {
  _cardButtons = cardButtons;
}

- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    Card* card = [self.game cardAtIndex:[_cardButtons indexOfObject:cardButton]];
    if (card.isFaceUp) {
      //Normal config is used by all other states as default (ie. selected and disabled)
      [cardButton setImage:nil forState:UIControlStateNormal];
      [cardButton setTitle:card.contents forState:UIControlStateNormal];
    } else {
      [cardButton setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
      [cardButton setTitle:nil forState:UIControlStateNormal];
    }
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (CardMatchingGame*) game {
  if (!_game) {
    _game = [[CardMatchingGame alloc]
             initWithCardCount:[self.cardButtons count]
                     usingDeck:[[PlayingCardDeck alloc] init]
             withCardsPerMatch:self.gameType];
  }
  return _game;
}

- (void) setFlipsCount:(int)flipsCount {
  _flipsCount = flipsCount;
  self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}

- (void) setLastAction:(NSString *)lastAction {
  _lastAction = lastAction;
  [self.actionHistory addObject:lastAction];
  self.lastActionLabel.alpha = 1.0;
  self.lastActionLabel.text = _lastAction;
}

- (IBAction)flipCard:(UIButton *)sender {
  NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
  self.historySlider.value = 1;
  self.lastAction = [self.game flipCardAtIndex:cardIndex];
  [self updateUI];
  self.flipsCount++;
  self.gameTypeControl.enabled = NO;
}


@end
