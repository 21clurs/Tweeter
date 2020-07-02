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

@interface TweetDetailViewController : UIViewController
@property (nonatomic,strong) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
