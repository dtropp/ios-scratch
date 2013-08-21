//
//  CardChooserViewController.m
//  CardViewer
//
//  Created by Dan Tropp on 21/08/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "CardChooserViewController.h"
#import "CardDisplayViewController.h"

@interface CardChooserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *suitControl;

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong, readonly) NSString *suit;

@end

@implementation CardChooserViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  CardDisplayViewController *cdvc = (CardDisplayViewController*)segue.destinationViewController;
  cdvc.suit = self.suit;
  cdvc.rank = self.rank;
}

- (NSString*) suit {
  return [self.suitControl titleForSegmentAtIndex:[self.suitControl selectedSegmentIndex]];
}

- (NSString *)rankAsString
{
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

- (IBAction)chooseRank:(UISlider *)sender {
  self.rank = round([sender value]);
  self.rankLabel.text = [self rankAsString];
}


@end
