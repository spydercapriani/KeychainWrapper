//
//  Keychain.swift
//  
//
//  Created by Danny Gilbert on 7/22/22.
//

import Foundation

public typealias KeychainAttributes = [String: Any]
public typealias KeychainQuery = [String: Any]
public typealias KeychainOptions = [String: Any]
public typealias KeychainItem = [String: Any]

public struct Keychain {
    
    public static func read(_ query: KeychainQuery, options: KeychainOptions) throws -> KeychainItem {
        let searchQuery = query
            .merging(options, uniquingKeysWith: { $1 })
        
        var container: CFTypeRef?
        let status = SecItemCopyMatching(
            searchQuery as CFDictionary,
            &container
        )
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledException(status: status, msg: "reading")
        }
        
        guard let item = container as? [String: Any] else {
            throw KeychainError.unexpectedData(nil)
        }
        
        return item
    }
    
    public static func update(_ attributes: KeychainAttributes, using query: KeychainQuery) throws {
        var status = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )
        
        if status == errSecItemNotFound {
            // Add the item if there was nothing to update.
            let addQuery = query
                .merging(attributes, uniquingKeysWith: { $1 })
            status = SecItemAdd(addQuery as CFDictionary, nil)
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledException(status: status, msg: "updating")
        }
    }
    
    public static func delete(_ query: KeychainQuery) throws {
        let status = SecItemDelete(query as CFDictionary)
        
        let successCodes: [OSStatus] = [
            errSecSuccess,
            errSecItemNotFound
        ]
        
        guard successCodes.contains(status) else {
            throw KeychainError.unhandledException(status: status, msg: "deleting")
        }
    }
}
