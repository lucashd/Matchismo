//
//  Deck.h
//  Matchismo
//
//  Created by Lucas David on 8/27/13.
//  Copyright (c) 2013 xalusc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
