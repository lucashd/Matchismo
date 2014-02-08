//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Lucas David
//  Copyright (c) 2014 lucashd. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@implementation ThreeCardMatchingGame

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    int matchScore = 0;
    
    if (!card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            // See if flipping the card up will create a match
            self.lastFlipDescription = [NSString stringWithFormat:@"Flipped %@.", card.contents];
            
            NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
            
            // Add each face up card to the array
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [faceUpCards addObject:otherCard];
                }
            }
            
            if (faceUpCards.count == 2)
            {
                matchScore = [card match:faceUpCards];
                if (matchScore)
                {
                    NSMutableArray *matchedCards = [[NSMutableArray alloc] init];
                    for (Card *otherCard in faceUpCards)
                    {
                        if (otherCard.isMatched)
                        {
                            otherCard.unplayable = YES;
                            [matchedCards addObject: otherCard];
                        }
                    }
                    if (card.isMatched)
                    {
                        card.unplayable = YES;
                        [matchedCards addObject: card];
                    }
                    
                    if (matchedCards.count == 2)
                    {
                        self.lastFlipDescription = [NSString stringWithFormat:@"Matched %@ and %@ for %d points!", [[matchedCards objectAtIndex:0] contents], [[matchedCards objectAtIndex:1] contents], matchScore];
                    }
                    else if (matchedCards.count == 3)
                    {
                        self.lastFlipDescription = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %d points!", [[matchedCards objectAtIndex:0] contents], [[matchedCards objectAtIndex:1] contents], [[matchedCards objectAtIndex:2] contents], matchScore];
                    }
                }
                self.score += matchScore;
            }
            else if (faceUpCards.count > 2)
            {
                for (Card *otherCard in faceUpCards)
                {
                    otherCard.faceUp = NO;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}


@end
