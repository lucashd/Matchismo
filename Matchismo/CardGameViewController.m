//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Lucas David
//  Copyright (c) 2014 lucashd. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "ThreeCardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) int tapCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *tapLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController
- (IBAction)switchGame:(UISegmentedControl *)sender {
    self.game = nil;
    
    if (self.gameSegmentControl.selectedSegmentIndex == 0)
    {
        self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        andDeck:[[PlayingCardDeck alloc] init]];
    }
    else
    {
        self.game = [[ThreeCardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                             andDeck:[[PlayingCardDeck alloc] init]];
    }
    self.gameSegmentControl.enabled = YES;
    self.flipCount = 0;
    self.tapCount++;
    [self updateUI];
}


- (IBAction)dealCards:(UIButton *)sender
{
    self.game = nil;
    
    if (self.gameSegmentControl.selectedSegmentIndex == 0)
    {
        self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        andDeck:[[PlayingCardDeck alloc] init]];
    }
    else
    {
        self.game = [[ThreeCardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        andDeck:[[PlayingCardDeck alloc] init]];
    }
    self.gameSegmentControl.enabled = YES;
    self.flipCount = 0;
    self.tapCount++;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Flip count updated to: %d", self.flipCount);
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                    andDeck:[[PlayingCardDeck alloc] init]];
        self.tapCount = 0;
    }
    return _game;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        
        UIImage *background = [UIImage imageNamed:@"bg.jpg"];
        if (!cardButton.isSelected || !cardButton.enabled)
        {
            [cardButton setBackgroundImage:background forState:UIControlStateNormal];
        }
        else
        {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        
    }
    self.tapLabel.text = [NSString stringWithFormat:@"Taps: %d", self.tapCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.descriptionLabel.text = self.game.lastFlipDescription;
}


- (IBAction)flipCard:(UIButton *)sender
{
    self.gameSegmentControl.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.tapCount++;
    [self updateUI];
}

@end
