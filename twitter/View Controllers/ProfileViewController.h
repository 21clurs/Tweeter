//
//  ProfileViewController.h
//  twitter
//
//  Created by Clara Kim on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) User *user;

@end

NS_ASSUME_NONNULL_END
