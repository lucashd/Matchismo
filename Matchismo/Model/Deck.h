//
//  Deck.h
//  Matchismo
//
//  Created by Lucas David
//  Copyright (c) 2013 lucashd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
