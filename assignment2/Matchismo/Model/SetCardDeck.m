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

+ (NSArray*) validColors {
  return @[@"▲",@"●",@"■"];
}

+ (NSArray*) validShapes {
  return @[@"red",@"green",@"purple"];
}

+ (NSUInteger) maxCount {
  return 3;
}

+ (NSArray*) validShading {
  return @[@"solid", @"striped", @"open"];
}


- (id) init {
  self = [super init];
  if (self) {
    for (NSString* shading in [self.class validShading]) {
      for (NSString* shape in [self.class validShapes]) {
        for (NSString* color in [self.class validColors]) {
          for (int count=1; count <= [self.class maxCount]; count++) {
            SetCard* card = [[SetCard alloc] initWithShape:shape
                                                      count:count
                                                      color:color
                                                    shading:shading];
            [self addCard:card atTop:NO];
          }
        }
      }
    }
    NSLog(@"Returning deck: %@", self);
  }
  
  return self;
}

@end
