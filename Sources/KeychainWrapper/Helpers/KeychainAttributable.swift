//
//  KeychainAttributable.swift
//  
//
//  Created by Danny Gilbert on 7/27/22.
//

import Foundation

public protocol KeychainAttributable {
    
    var key: String { get }
    var value: Any { get }
}

public extension KeychainAttributable {
    
    var attribute: KeychainAttribute {
        KeychainAttribute(key: key, value: value)
    }
}
