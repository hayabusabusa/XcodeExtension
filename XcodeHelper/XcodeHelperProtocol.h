//
//  XcodeHelperProtocol.h
//  XcodeHelper
//
//  Created by Shunya Yamada on 2022/03/05.
//

#import <Foundation/Foundation.h>

@protocol XcodeHelperProtocol

- (void)project:(void (^_Nonnull)(NSString * _Nonnull))reply;
    
@end
