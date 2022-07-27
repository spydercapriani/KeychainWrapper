//
//  KeychainOptions.swift
//  
//
//  Created by Danny Gilbert on 7/25/22.
//

import Foundation

public struct KeychainOption {
    let key: String
    let value: Any
    
    public init(
        key: String,
        value: Any
    ) {
        self.key = key
        self.value = value
    }
}

// MARK: - Match Limit
extension KeychainOption {
    
    public enum MatchLimit: String {
        case first
        case all
        
        public var rawValue: String {
            switch self {
            case .first:    return kSecMatchLimitOne.string
            case .all:      return kSecMatchLimitAll.string
            }
        }
    }
}

// MARK: - Hashable
extension KeychainOption: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.key)
    }
    
    public static func == (lhs: KeychainOption, rhs: KeychainOption) -> Bool {
        lhs.key == rhs.key
    }
}

// MARK: - Query
public extension Set where Element == KeychainOption {
    
    var query: KeychainQuery {
        self.reduce(into: [String: Any]()) { result, option in
            result[option.key] = option.value
        }
    }
}

// MARK: - Predefined Options
public extension Set where Element == KeychainOption {
    
    static var matchFirst: Set<KeychainOption> {
        [
            .returnData(true),
            .returnAttributes(true),
            .matchLimit(.first)
        ]
    }
    
    static var matchAll: Set<KeychainOption> {
        [
            .returnData(true),
            .returnAttributes(true),
            .matchLimit(.all)
        ]
    }
}

// MARK: - Built-In Options
public extension KeychainOption {
    
    static func returnAttributes(_ value: Bool) -> KeychainOption {
        KeychainOption(
            key: kSecReturnAttributes.string,
            value: value
        )
    }
    
    static func returnData(_ value: Bool) -> KeychainOption {
        KeychainOption(
            key: kSecReturnData.string,
            value: value
        )
    }
    
    static func matchLimit(_ option: MatchLimit) -> KeychainOption {
        KeychainOption(
            key: kSecMatchLimit.string,
            value: option.rawValue
        )
    }
}
