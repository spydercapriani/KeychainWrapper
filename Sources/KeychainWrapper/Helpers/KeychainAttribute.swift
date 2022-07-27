//
//  Attributes.swift
//  
//
//  Created by Danny Gilbert on 7/21/22.
//

import Foundation

public struct KeychainAttribute {
    public let key: String
    public let value: Any
    
    public init(
        key: String,
        value: Any
    ) {
        self.key = key
        self.value = value
    }
}

// MARK: - KeychainAttribute - Equatable
extension KeychainAttribute: Equatable {
    
    public static func == (lhs: KeychainAttribute, rhs: KeychainAttribute) -> Bool {
        lhs.key == rhs.key
    }
}

// MARK: - KeychainAttribute - Hashable
extension KeychainAttribute: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}

// MARK: Array - KeychainAttribute
public extension Set where Element == KeychainAttribute {

    var query: [String: Any] {
        self.reduce(into: [String: Any]()) { result, attribute in
            result[attribute.key] = attribute.value
        }
    }
}
