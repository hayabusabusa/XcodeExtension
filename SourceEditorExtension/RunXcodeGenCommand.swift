//
//  RunXcodeGenCommand.swift
//  SourceEditorExtension
//
//  Created by Shunya Yamada on 2022/03/05.
//

import Foundation
import XcodeKit

final class RunXcodeGenCommand: NSObject, XCSourceEditorCommand {
    
    private let connection = { () -> NSXPCConnection in
        let connection = NSXPCConnection(serviceName: "jp.co.sample.XcodeExtension.CommandHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: CommandHelperProtocol.self)
        return connection
    }()
    
    deinit {
        connection.invalidate()
    }
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        
    }
}

private extension RunXcodeGenCommand {
    
    func execute(_ command: String, in directory: String) throws {
        connection.resume()
        
        defer {
            connection.suspend()
        }
        
        guard let xpc = connection.remoteObjectProxy as? CommandHelperProtocol else {
            print("Failed to connect: \(connection)")
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var (status, output, errorOutput) = (0, "", "")
        xpc.execute(command, with: [], in: directory) {
            (status, output, errorOutput) = ($0, $1, $2)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 10)
        
        print("🛠 [DEBUG] STATUS: \(status), OUTPUT: \(output), ERROR: \(errorOutput)")
    }
}
