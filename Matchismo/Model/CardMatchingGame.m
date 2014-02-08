//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Lucas David on 8/30/13.
//  Copyright (c) 2013 xalusc. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardMatchingGame ()

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count andDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }
            else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    int matchScore = 0;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            // See if flipping the card up will create a match
            self.lastFlipDescription = [NSString stringWithFormat:@"Flipped %@.", card.contents];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.lastFlipDescription = [NSString stringWithFormat:@"Flipped %@ and %@ for %d points!", card.contents, otherCard.contents, (matchScore * MATCH_BONUS)];
                    }
                    else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastFlipDescription = [NSString stringWithFormat:@"%@ and %@ don't match, %d penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}
@end
