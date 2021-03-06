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
#import "ComposeViewController.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
     UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePicView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePicView setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAtLabel.text = tweet.createdAtString;
    self.tweetTextLabel.text = tweet.text;
    
    [self refreshData];
    
    self.profilePicView.image = nil;
    NSURL *profilePicURL = [NSURL URLWithString:tweet.user.profilePicURLString];
    [self.profilePicView setImageWithURL:profilePicURL];
}

- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = !self.tweet.favorited;
    
    if(self.tweet.favorited == YES){
        __weak typeof(self) weakSelf = self;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof (self) strongSelf = weakSelf;
            if (tweet) {
                //self.tweet = tweet;
                strongSelf.tweet.favoriteCount = tweet.favoriteCount;
                strongSelf.tweet.favorited = YES;
                [strongSelf refreshData];
            } else {
                NSLog(@"Error favoriting tweet");
            }
        }];
    }
    else{
        __weak typeof(self) weakSelf = self;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof (self) strongSelf = weakSelf;
            if (tweet) {
                strongSelf.tweet.favoriteCount = tweet.favoriteCount;
                strongSelf.tweet.favorited = NO;
                [strongSelf refreshData];
            } else {
                NSLog(@"Error unfavoriting tweet");
            }
        }];
    }
    //[self refreshData];
    
}
- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted == NO){
        __weak typeof(self) weakSelf = self;
        [[APIManager shared]retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof (self) strongSelf = weakSelf;
            if (tweet) {
                // why does setting self.tweet = tweet cause buggy things here.
                strongSelf.tweet.retweeted = YES;
                strongSelf.tweet.retweetCount = tweet.retweetCount;
                [strongSelf refreshData];
            } else {
                NSLog(@"Error retweeting tweet");
            }
        }];
    }
    else{
        __weak typeof(self) weakSelf = self;
        [[APIManager shared]unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof (self) strongSelf = weakSelf;
            if (tweet) {
                //self.tweet = tweet;
                strongSelf.tweet.retweeted=NO;
                strongSelf.tweet.retweetCount = tweet.retweetCount-1;
                [strongSelf refreshData];
                
            } else {
                NSLog(@"Error unretweeting tweet");
            }
        }];
    }
}

- (IBAction)didTapReply:(id)sender {
    [self.delegate tweetCell:self didReply:self.tweet];
}

- (void)refreshData{
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount] forState:UIControlStateNormal];
    [self.favButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] forState:UIControlStateNormal];
    
    if(self.tweet.favorited == YES){
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        [self.favButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    }
    else{
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        [self.favButton setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        ;
    }
    
    if(self.tweet.retweeted == YES){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        [self.retweetButton setTitleColor:UIColor.systemGreenColor forState:UIControlStateNormal];
    }
    else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        [self.retweetButton setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    }
}

- (void)didTapUserProfile:(UITapGestureRecognizer *)sender{
    // TODO: Call method on delegate
    
    [self.delegate tweetCell:self didTap:self.tweet.user];
}



@end
