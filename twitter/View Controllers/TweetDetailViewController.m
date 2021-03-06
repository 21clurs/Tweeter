//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Clara Kim on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "ComposeViewController.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profilePicView.image = nil;
    NSURL *profilePicURL = [NSURL URLWithString:self.tweet.user.profilePicURLString];
    [self.profilePicView setImageWithURL:profilePicURL];
    
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetTextLabel.text = self.tweet.text;
    
    self.timeLabel.text = self.tweet.timeCreatedString;
    self.dateLabel.text = self.tweet.dateCreatedString;
    
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted == NO){
        __weak typeof(self) weakSelf = self;
        [[APIManager shared]retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof(self) strongSelf = weakSelf;
            if (tweet) {
                strongSelf.tweet = tweet;
                [strongSelf refreshData];
            } else {
                NSLog(@"Error retweeting tweet");
            }
        }];
    }
    else{
        __weak typeof(self) weakSelf = self;
        [[APIManager shared]unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof(self) strongSelf = weakSelf;
            if (tweet) {
                //self.tweet = tweet;
                strongSelf.tweet.retweeted = NO;
                strongSelf.tweet.retweetCount = tweet.retweetCount-1;
                [strongSelf refreshData];
                
            } else {
                NSLog(@"Error unretweeting tweet");
            }
        }];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = !self.tweet.favorited;
    
    if(self.tweet.favorited == YES){
        __weak typeof(self) weakSelf = self;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof(self) strongSelf = weakSelf;
            if (tweet) {
                strongSelf.tweet = tweet;
                [strongSelf refreshData];
            } else {
                NSLog(@"Error favoriting tweet");
            }
        }];
    }
    else{
        __weak typeof(self) weakSelf = self;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            __strong typeof(self) strongSelf = weakSelf;
            if (tweet) {
                strongSelf.tweet = tweet;
                [strongSelf refreshData];
            } else {
                NSLog(@"Error unfavoriting tweet");
            }
        }];
    }
    [self refreshData];
}

- (void)refreshData{
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    if(self.tweet.favorited == YES){
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    else{
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    if(self.tweet.retweeted == YES){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.delegate returnToTimeline:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.replyToTweet = self.tweet;
}

@end
