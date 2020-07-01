//
//  TweetCell.m
//  twitter
//
//  Created by Clara Kim on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = !self.tweet.favorited;
    
    
}
- (IBAction)didTapRetweet:(id)sender {
}

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAtLabel.text = tweet.createdAtString;
    self.tweetTextLabel.text = tweet.text;
    
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.replyLabel.text = @"";
    
    self.profilePicView.image = nil;
    NSURL *profilePicURL = [NSURL URLWithString:tweet.user.profilePicURLString];
    [self.profilePicView setImageWithURL:profilePicURL];
}


@end
