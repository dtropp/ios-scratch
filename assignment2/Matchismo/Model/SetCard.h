//
//  SetCard.h
//  Matchismo2
//
//  Created by Dan Tropp on 31/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

-(id) initWithSymbol:(NSString*) symbol
               count:(NSUInteger) count
               color:(UIColor*)color
             shading:(float)alpha;

@end
