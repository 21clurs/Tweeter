//
//  TweetCell.m
//  twitter
//
//  Created by Clara Kim on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAtLabel.text = tweet.createdAtString;
    self.tweetTextLabel.text = tweet.text;
    
    [self refreshData];
    self.replyLabel.text = @"";
    
    self.profilePicView.image = nil;
    NSURL *profilePicURL = [NSURL URLWithString:tweet.user.profilePicURLString];
    [self.profilePicView setImageWithURL:profilePicURL];
}

- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = !self.tweet.favorited;
    
    if(self.tweet.favorited == YES){
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (tweet) {
                self.tweet = tweet;
            } else {
                NSLog(@"Error favoriting tweet");
            }
        }];
    }
    else{
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (tweet) {
                self.tweet = tweet;
            } else {
                NSLog(@"Error unfavoriting tweet");
            }
        }];
    }
    [self refreshData];
    
}
- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = !self.tweet.retweeted;
    
    if(self.tweet.retweeted == YES){
        [[APIManager shared]retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (tweet) {
                self.tweet = tweet;
            } else {
                NSLog(@"Error retweeting tweet");
            }
        }];
    }
    else{
        [[APIManager shared]unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (tweet) {
                self.tweet = tweet;
                
            } else {
                NSLog(@"Error unretweeting tweet");
            }
        }];
    }
    //[self refreshData];
}

- (void)refreshData{
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    if(self.tweet.favorited == YES){
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        self.favLabel.textColor = UIColor.redColor;
    }
    else{
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        self.favLabel.textColor = UIColor.darkGrayColor
        ;
    }
    
    if(self.tweet.retweeted == YES){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        self.retweetLabel.textColor = UIColor.greenColor;
    }
    else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        self.retweetLabel.textColor = UIColor.darkGrayColor;
    }
}



@end
