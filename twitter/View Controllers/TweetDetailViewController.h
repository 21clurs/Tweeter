//
//  TweetDetailViewController.h
//  twitter
//
//  Created by Clara Kim on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailViewControllerDelegate

- (void)returnToTimeline:(Tweet *)tweet;

@end

@interface TweetDetailViewController : UIViewController
@property (nonatomic,strong) Tweet *tweet;
@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
