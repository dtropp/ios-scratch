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
@property (strong, nonatomic) NSString* shape;
@property (nonatomic) NSUInteger count;

-(id) initWithShape:(NSString*) shape
               count:(NSUInteger) count
               color:(NSString *)color
             shading:(NSString *)shading;

@end
