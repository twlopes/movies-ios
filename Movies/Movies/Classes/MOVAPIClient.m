//
//  MOVAPIClient.m
//  Movies
//
//  Created by Tristan Lopes on 21/02/2014.
//  Copyright (c) 2014 hotcandy. All rights reserved.
//

#import "MOVAPIClient.h"

#import "AFHTTPSessionManager.h"
#import "AFNetworkActivityIndicatorManager.h"

NSString * const MOVNetworkStatusCodeErrorKey = @"MOVNetworkStatusCodeErrorKey";

@interface MOVAPIClient ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation MOVAPIClient

#pragma mark - Public

- (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(MOVNetworkSuccessBlock)success failure:(MOVNetworkFailureBlock)failure
{
    [AFNetworkActivityIndicatorManager.sharedManager incrementActivityCount];

    return [self.sessionManager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [AFNetworkActivityIndicatorManager.sharedManager decrementActivityCount];

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [AFNetworkActivityIndicatorManager.sharedManager decrementActivityCount];

        NSError *returnError = [self augmentedErrorFromTask:task error:error];
        if (failure) {
            failure(returnError);
        }
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(MOVNetworkSuccessBlock)success failure:(MOVNetworkFailureBlock)failure
{
    [AFNetworkActivityIndicatorManager.sharedManager incrementActivityCount];

    return [self.sessionManager POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [AFNetworkActivityIndicatorManager.sharedManager decrementActivityCount];

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [AFNetworkActivityIndicatorManager.sharedManager decrementActivityCount];

        NSError *returnError = [self augmentedErrorFromTask:task error:error];
        if (failure) {
            failure(returnError);
        }
    }];
}

#pragma mark - Helpers

- (NSError *)augmentedErrorFromTask:(NSURLSessionDataTask *)task error:(NSError *)error {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (error.userInfo) {
        [userInfo addEntriesFromDictionary:error.userInfo];
    }
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    userInfo[MOVNetworkStatusCodeErrorKey] = @(response ? response.statusCode : NSNotFound);
    return [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
}

#pragma mark - Initialisation

+ (MOVAPIClient *)sharedClient
{
    static MOVAPIClient *_sharedAPIClient = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAPIClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:MOVAPI.RT.BaseURL]];
    });

    return _sharedAPIClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super init]) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }

    return self;
}

@end
