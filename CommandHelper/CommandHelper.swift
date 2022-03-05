//
//  CommandHelper.swift
//  CommandHelper
//
//  Created by Shunya Yamada on 2022/03/05.
//

import Foundation

@objc
final class CommandHelper: NSObject, CommandHelperProtocol {
    
    func execute(_ command: String, with arguments: [String], in directory: String, reply: @escaping CommandHelperHandler) {
        let standardOutput = Pipe()
        let standardError = Pipe()
        
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["/usr/local/bin/\(command)"] + arguments
        task.currentDirectoryPath = directory
        task.standardOutput = standardOutput
        task.standardError = standardError
        task.launch()
        
        let output = String(data: standardOutput.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
        let error = String(data: standardError.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
        
        reply(Int(task.terminationStatus), output, error)
    }
}
