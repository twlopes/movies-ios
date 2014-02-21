//
//  MOVAPIClient.h
//  Movies
//
//  Created by Tristan Lopes on 21/02/2014.
//  Copyright (c) 2014 hotcandy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MOVNetworkStatusCodeErrorKey;

typedef void(^MOVNetworkFailureBlock)(NSError *error);
typedef void(^MOVNetworkSuccessBlock)(id responseObject);

@interface MOVAPIClient : NSObject

+ (MOVAPIClient *)sharedClient;

- (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(MOVNetworkSuccessBlock)success failure:(MOVNetworkFailureBlock)failure;
- (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(MOVNetworkSuccessBlock)success failure:(MOVNetworkFailureBlock)failure;

@end
