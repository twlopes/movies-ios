//
//  MOVEnvironmentConfig.h
//  Movies
//
//  Created by Tristan Lopes on 21/02/2014.
//  Copyright (c) 2014 hotcandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MOVEnvironmentConfig_h
#define MOVEnvironmentConfig_h

#ifdef DEBUG
    #define ENABLE_LOCAL_LOGGING
    #define ENABLE_NETWORK_LOGGING
//    #define ENABLE_NETWORK_LOGGING_VERBOSE
#endif


#ifdef ADHOC
//    #define ENABLE_LOCAL_LOGGING
//    #define ENABLE_NETWORK_LOGGING
//    #define ENABLE_NETWORK_LOGGING_VERBOSE
#endif


#ifdef RELEASE
//    #define ENABLE_LOCAL_LOGGING
//    #define ENABLE_NETWORK_LOGGING
//    #define ENABLE_NETWORK_LOGGING_VERBOSE
#endif



#ifndef ENABLE_LOCAL_LOGGING
    #define NSLog(...)
#endif

#endif