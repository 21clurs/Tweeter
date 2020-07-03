//
//  User.h
//  twitter
//
//  Created by Clara Kim on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicURLString;
@property (nonatomic, strong) NSString *bannerPicURLString;

@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *userIDString;
@property (nonatomic, strong) NSNumber *tweetCount;
@property (nonatomic, strong) NSNumber *followerCount;
@property (nonatomic, strong) NSNumber *followingCount;

- (instancetype)initWithDictionary: (NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
