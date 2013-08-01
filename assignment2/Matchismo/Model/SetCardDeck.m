//
//  SetCardDeck.m
//  Matchismo2
//
//  Created by Dan Tropp on 1/08/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

+ (NSArray*) validShapes {
  return @[@"▲",@"●",@"■"];
}

- (id) init {
  self = [super init];
  if (self) {
    for (int i = 0; i < 3; i++) {
      for (NSString* shape in [self.class validShapes]) {
        for (int count=1; count <= 3; count++) {
          SetCard* card = [[SetCard alloc] initWithSymbol:shape
                                                    count:count
                                                    color:[UIColor redColor]
                                                  shading:1.0];
          [self addCard:card atTop:NO];
        }
      }
    }
  }
  
  NSLog(@"Returning deck: %@", self);
  return self;
}

@end
