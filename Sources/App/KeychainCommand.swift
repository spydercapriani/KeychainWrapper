//
//  KeychainCommand.swift
//  
//
//  Created by Danny Gilbert on 7/15/22.
//

import Foundation
import ConsoleKit
import KeychainWrapper

class KeychainCommand: Command {
    
    struct Signature: CommandSignature {
        @Argument(
            name: "item",
            help: "Keychain Service Item"
        )
        var service: String
        
        @Option(
            name: "label",
            short: "l",
            help: "Keychain Item Label"
        )
        var label: String?

        @Option(
            name: "username",
            short: "u",
            help: "Specify Username"
        )
        var account: String?
    }
    
    let help = "This command helps lookup keychain passwords."
    
    func run(using context: CommandContext, signature: Signature) throws {
        
        let credentials = SecureCredentials(
            label: signature.label,
            service: signature.service,
            account: signature.account
        )
        
        // Create item if doesn't already exist
        if credentials.wrappedValue == nil {
            let account = credentials.account ?? context.console.ask("What is your username?")
            credentials.wrappedValue = context.console.ask("What would you like to set your password as?", isSecure: true)
            credentials.account = account
        }
        
        if credentials.wrappedValue != nil {
            context.console.success("Password has been set!")
        }
    }
}
