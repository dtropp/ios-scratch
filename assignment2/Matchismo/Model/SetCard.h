//
//  SetCard.h
//  Matchismo2
//
//  Created by Dan Tropp on 31/07/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString* color;
@property (strong, nonatomic) NSString* shading;

- (NSString*) symbols;

-(id) initWithSymbol:(NSString*) symbol
               count:(NSUInteger) count
               color:(NSString *)color
             shading:(NSString *)shading;

@end
