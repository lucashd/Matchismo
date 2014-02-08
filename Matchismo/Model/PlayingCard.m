//
//  PlayingCard.m
//  Matchismo
//
//  Created by Lucas David on 8/27/13.
//  Copyright (c) 2013 xalusc. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == 1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = 1;
            }
            else if (otherPlayingCard.rank == self.rank) {
                score = 4;
            }
        }
                
    }
    else if (otherCards.count == 2) {
        PlayingCard *firstCard = otherCards[0];
        PlayingCard *secondCard = otherCards[1];
        
        if ([firstCard.suit isEqualToString:self.suit]) {
            firstCard.matched = YES;
            self.matched = YES;
            score += 1;
        }
        else if (firstCard.rank == self.rank) {
            firstCard.matched = YES;
            self.matched = YES;
            score += 4;
        }
        
        if ([firstCard.suit isEqualToString:secondCard.suit]) {
            firstCard.matched = YES;
            secondCard.matched = YES;
            score += 1;
        }
        else if (firstCard.rank == secondCard.rank) {
            firstCard.matched = YES;
            secondCard.matched = YES;
            score += 4;
        }

        if ([secondCard.suit isEqualToString:self.suit]) {
            secondCard.matched = YES;
            self.matched = YES;
            score += 1;
        }
        else if (secondCard.rank == self.rank) {
            secondCard.matched = YES;
            self.matched = YES;
            score += 4;
        }
        
    }
    return score;
}
+ (NSArray *)validSuits {
    static NSArray* validSuits = nil;
    if (!validSuits) validSuits = @[@"♣",@"♥",@"♦",@"♠"];
    return validSuits;
}

+ (NSUInteger)maxRank {
    return [PlayingCard rankStrings].count - 1;
}

+ (NSArray *)rankStrings {
    static NSArray* rankStrings = nil;
    if (!rankStrings) rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return rankStrings;
}

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *) suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}



@end
