//
//  MOVConstants.h
//  Movies
//
//  Created by Tristan Lopes on 21/02/2014.
//  Copyright (c) 2014 hotcandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MOVConstString __unsafe_unretained NSString *

// Network
extern const struct MOVAPI {
    struct {
        MOVConstString BaseURL;

        struct {

        } Path;
        struct {
            MOVConstString APIKey;
        } Parameter;
    } RT;
} MOVAPI;
