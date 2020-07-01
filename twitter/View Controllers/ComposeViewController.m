//
//  ComposeViewController.m
//  twitter
//
//  Created by Clara Kim on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)publishTweetAction:(id)sender {
    NSString *tweetText = self.composeTextView.text;
    [[APIManager shared] postStatusWithUpdate:tweetText completion:^(Tweet *tweet, NSError *error) {
        if (error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
        
        
    }];
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
