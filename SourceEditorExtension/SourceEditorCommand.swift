//
//  SourceEditorCommand.swift
//  SourceEditorExtension
//
//  Created by Shunya Yamada on 2022/03/04.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        try! project()
        try! execute("pod", with: ["--version"], in: NSTemporaryDirectory())
        
        completionHandler(nil)
    }
    
    private func project() throws {
        let connection = NSXPCConnection(serviceName: "jp.co.shunya.yamada.XcodeExtension.XcodeHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
        connection.resume()
        
        guard let xpc = connection.remoteObjectProxy as? XcodeHelperProtocol else {
            print("Failed to connect: \(connection)")
            return
        }
        
        xpc.project { path in
            print("🛠 [DEBUG] Xcode \(path)")
            connection.invalidate()
        }
    }
    
    private func execute(_ command: String, with arguments: [String], in directory: String) throws {
        let connection = NSXPCConnection(serviceName: "jp.co.shunya.yamada.XcodeExtension.CommandHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: CommandHelperProtocol.self)
        connection.resume()
        
        guard let xpc = connection.remoteObjectProxy as? CommandHelperProtocol else {
            print("Failed to connect: \(connection)")
            return
        }
        
        //var (status, output, errorOutput) = (0, "", "")
        xpc.execute(command, with: arguments, in: directory) { status, output, errorOutput in
            //(status, output, errorOutput) = ($0, $1, $2)
            print("🛠 [DEBUG] STATUS: \(status), OUTPUT: \(output), ERROR: \(errorOutput)")
            connection.invalidate()
        }
    }
}
