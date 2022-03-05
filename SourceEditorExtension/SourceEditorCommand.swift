//
//  SourceEditorCommand.swift
//  SourceEditorExtension
//
//  Created by Shunya Yamada on 2022/03/04.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        invocation.buffer.lines.add("Hello extension!")
        
        let standardOutput = Pipe()
        let standardError = Pipe()
        
        let task = Process()
        task.standardOutput = standardOutput
        task.standardError = standardError
        task.launch()
        
        completionHandler(nil)
    }
    
}
