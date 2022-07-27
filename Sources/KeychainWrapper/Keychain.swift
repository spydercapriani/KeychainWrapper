//
//  Keychain.swift
//  
//
//  Created by Danny Gilbert on 7/22/22.
//

import Foundation

public typealias KeychainQuery = [String: Any]
public typealias KeychainItem = [String: Any]
public typealias KeychainAttributes = Set<KeychainAttribute>
public typealias KeychainOptions = Set<KeychainOption>

public struct Keychain {
    
    @available(*, renamed: "search", message: "Consider conforming to KeychainQueryable")
    public static func read(_ query: [String: Any], options: [String: Any]) throws -> KeychainItem {
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
    
    @available(*, renamed: "modify", message: "Consider conforming to KeychainQueryable")
    public static func update(_ attributes: [String: Any], using query: [String: Any]) throws {
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
    
    @available(*, renamed: "remove", message: "Consider conforming to KeychainQueryable")
    public static func delete(_ query: [String: Any]) throws {
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

// MARK: - Keychain Attribute Convenience Actions
public extension Keychain {
    
    static func search(for attributes: KeychainAttributes, with options: KeychainOptions) throws -> KeychainItem {
        try read(attributes.query, options: options.query)
    }
    
    static func modify(_ attributes: KeychainAttributes, for existingAttributes: KeychainAttributes) throws {
        try update(attributes.query, using: existingAttributes.query)
    }
    
    static func remove(_ attributes: KeychainAttributes) throws {
        try delete(attributes.query)
    }
}


// MARK: - KeychainQueryable Convenience Actions
public extension Keychain {
    
    static func search(for queryable: KeychainQueryable) throws -> KeychainItem {
        try search(for: queryable.attributes, with: queryable.options)
    }
    
    static func modify(_ attributes: KeychainAttributes, for queryable: KeychainQueryable) throws {
        try modify(attributes, for: queryable.attributes)
    }
    
    static func remove(_ queryable: KeychainQueryable) throws {
        try remove(queryable.attributes)
    }
}
