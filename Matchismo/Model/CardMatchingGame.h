//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Lucas David on 8/30/13.
//  Copyright (c) 2013 xalusc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount andDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;


@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *lastFlipDescription;

@end
