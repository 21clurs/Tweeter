//
//  User.m
//  twitter
//
//  Created by Clara Kim on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype) initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        
        //self.profilePicURLString = dictionary[@"profile_image_url_https"];
        self.profilePicURLString = [dictionary[@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        self.bannerPicURLString = [dictionary[@"profile_banner_url"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        
        self.tagline = dictionary[@"description"];
        self.userIDString = dictionary[@"id_str"];
        self.tweetCount = dictionary[@"statuses_count"];
        self.followerCount = dictionary[@"followers_count"];
        self.followingCount = dictionary[@"friends_count"];
    }
    return self;
}

@end
