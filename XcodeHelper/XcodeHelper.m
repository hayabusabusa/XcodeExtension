//
//  XcodeHelper.m
//  XcodeHelper
//
//  Created by Shunya Yamada on 2022/03/05.
//

#import "XcodeHelper.h"

@implementation XcodeHelper

- (void)project:(void (^ _Nonnull)(NSString * _Nonnull))reply {
    XcodeApplication *app = [SBApplication applicationWithBundleIdentifier:@"com.apple.dt.Xcode"];
    XcodeWorkspaceDocument *document = app.activeWorkspaceDocument;
    reply([NSString stringWithFormat:@"%@, %@", app.version, document.file]);
}

@end
