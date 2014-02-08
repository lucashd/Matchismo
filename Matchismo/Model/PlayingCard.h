//
//  PlayingCard.h
//  Matchismo
//
//  Created by Lucas David on 8/27/13.
//  Copyright (c) 2013 xalusc. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;


@end
