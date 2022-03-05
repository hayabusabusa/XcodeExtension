//
//  CommandHelperProtocol.h
//  CommandHelper
//
//  Created by Shunya Yamada on 2022/03/05.
//

#import <Foundation/Foundation.h>

typedef void (^CommandHelperHandler)(NSInteger status, NSString * _Nonnull, NSString * _Nonnull);

@protocol CommandHelperProtocol

- (void)execute:(NSString * _Nonnull)command
           with:(NSArray<NSString *> * _Nonnull)arguments
             in:(NSString * _Nonnull)directory
          reply:(CommandHelperHandler _Nonnull)reply
NS_SWIFT_NAME(execute(_:with:in:reply:));
    
@end
