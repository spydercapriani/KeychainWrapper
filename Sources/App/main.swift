//
//  main.swift
//  
//
//  Created by Danny Gilbert on 6/27/22.
//

import Foundation
import ConsoleKit

struct Playground: CommandGroup {
    
    let commands: [String : AnyCommand] = [
        "keychain": KeychainCommand()
    ]
    
    let defaultCommand: AnyCommand? = KeychainCommand()
    
    let help = "Playground CLI App"
}

let console: Console = Terminal()

do {
    let input = CommandInput(arguments: CommandLine.arguments)
    let group = Playground()
    try console.run(group, input: input)
} catch {
    console.error("\(error)")
    exit(1)
}
