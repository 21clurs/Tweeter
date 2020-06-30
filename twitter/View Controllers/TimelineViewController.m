//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [tweets mutableCopy];
            
            [self.tableView reloadData];
            
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
             
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.nameLabel.text = tweet.user.name;
    cell.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    cell.createdAtLabel.text = tweet.createdAtString;
    cell.tweetTextLabel.text = tweet.text;
    
    cell.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    cell.favLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
    if  (tweet.user.profilePicURLString != nil){
        NSURL *profilePicURL = [NSURL URLWithString:tweet.user.profilePicURLString];
        cell.profilePicView.image = nil;
        //cell.profilePicView.layer.cornerRadius = 5;
        [cell.profilePicView setImageWithURL:profilePicURL];
    }
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    return cell;
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
