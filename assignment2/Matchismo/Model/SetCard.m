//
//  SetCard.m
//  Matchismo2
//
//  Created by Dan Tropp on 31/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "SetCard.h"
@interface SetCard()

@property (strong, nonatomic) NSString* symbol;
@property (nonatomic) NSUInteger count;
@property (weak, nonatomic) UIColor* color;
@property (nonatomic) float alpha;
@property (strong, nonatomic) NSAttributedString* formattedContents;

@end

@implementation SetCard

- (id)initWithSymbol:(NSString *)symbol
               count:(NSUInteger)count
               color:(UIColor *)color
             shading:(float)alpha {
  self = [super init];
  
  if (self) {
    self.symbol = symbol;
    self.count = count;
    self.color = color;
    self.alpha = alpha;
    
    self.contents = symbol;
    for (int i = 1; i < count; i++) {
      self.contents = [self.contents stringByAppendingString:symbol];
    }
    
    self.formattedContents =
      [[NSAttributedString alloc] initWithString:self.contents
                                      attributes:@{}];
    NSLog(@"SetCard init with contents:%@ formattedContents:%@",
          self.contents, self.formattedContents);
  }
  return self;
}


@end
