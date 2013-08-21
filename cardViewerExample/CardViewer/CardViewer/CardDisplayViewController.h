//
//  CardDisplayViewController.h
//  CardViewer
//
//  Created by Dan Tropp on 21/08/13.
//  Copyright (c) 2013 Dan Tropp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardDisplayViewController : UIViewController

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;

@end
