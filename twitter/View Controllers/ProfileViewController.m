//
//  ProfileViewController.m
//  twitter
//
//  Created by Clara Kim on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
}

- (void)refreshData{
    NSURL *profilePhotoURL = [NSURL URLWithString:self.user.profilePicURLString];
    [self.profilePhotoView setImageWithURL:profilePhotoURL];
    NSURL *bannerPhotoURL = [NSURL URLWithString:self.user.bannerPicURLString];
    [self.bannerPhotoView setImageWithURL:bannerPhotoURL];
    
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.taglineLabel.text = self.user.tagline;
    self.tweetCountLabel.text = [NSString stringWithFormat:@"%@", self.user.tweetCount];
    self.followerCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followerCount];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followingCount];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
