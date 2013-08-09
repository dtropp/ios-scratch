//
//  MatchResult.h
//  Matchismo2
//
//  Created by Dan Tropp on 9/08/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface FlipResult : NSObject

@property (nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray* cards;

- (BOOL) isMatch;
- (BOOL) isMismatch;
- (id) initWithCard:(Card*)card;

@end
