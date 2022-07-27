//
//  KeychainQueryable.swift
//  
//
//  Created by Danny Gilbert on 7/25/22.
//

import Foundation

public protocol KeychainQueryable {
    
    var attributes: KeychainAttributes { get }
    var options: KeychainOptions { get }
}

// MARK: - CRUD Keychain Actions
public extension KeychainQueryable {
    
    var item: KeychainItem {
        get throws {
            try Keychain.search(for: attributes, with: options)
        }
    }
    
    func update(_ attributes: KeychainAttribute...) throws {
        let uniqueAttributes = KeychainAttributes(attributes)
        try Keychain.modify(uniqueAttributes, for: self)
    }
    
    func delete() throws {
        try Keychain.remove(self)
    }
}
