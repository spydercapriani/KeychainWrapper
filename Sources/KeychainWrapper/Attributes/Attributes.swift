//
//  Attributes.swift
//  
//
//  Created by Danny Gilbert on 7/26/22.
//

import Foundation

// MARK: Built-in Attributes Namespace
// MARK: - Global Keys
public extension KeychainAttribute {
    
    static func kind(_ value: KeychainCatalog.Kind) -> KeychainAttribute {
        KeychainCatalog.Global.kind(value).attribute
    }
    
    static func account(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Global.account(value).attribute
    }
    
    static func password(_ value: Data) -> KeychainAttribute {
        KeychainCatalog.Global.password(value).attribute
    }
}

// MARK: - Internet Keys
public extension KeychainAttribute {
    
    static func server(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Internet.server(value).attribute
    }
    
    static func securityDomain(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Internet.securityDomain(value)
            .attribute
    }
    
    static func port(_ value: Int) -> KeychainAttribute {
        KeychainCatalog.Internet.port(value)
            .attribute
    }
    
    static func authentication(_ value: KeychainCatalog.Internet.AuthenticationType) -> KeychainAttribute {
        KeychainCatalog.Internet.authentication(value)
            .attribute
    }
    
    static func path(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Internet.path(value)
            .attribute
    }
    
    static func `protocol`(_ value: InternetProtocol) -> KeychainAttribute {
        KeychainCatalog.Internet.protocol(value)
            .attribute
    }
}

// MARK: - Application Keys
public extension KeychainAttribute {
    
    static func service(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Application.service(value)
            .attribute
    }
    
    static func accessControl(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Application.accessControl(value)
            .attribute
    }
    
    static func generic(_ value: Data) -> KeychainAttribute {
        KeychainCatalog.Application.generic(value)
            .attribute
    }
}

// MARK: - Entry Keys
public extension KeychainAttribute {
    
    static let creationDate: KeychainAttribute = KeychainCatalog.Entry.creationDate.attribute
    static let modificationDate: KeychainAttribute = KeychainCatalog.Entry.modificationDate.attribute
    
    static func description(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Entry.description(value)
            .attribute
    }
    
    static func comment(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Entry.comment(value)
            .attribute
    }
    
    static func creator(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Entry.creator(value)
            .attribute
    }
    
    static func type(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Entry.type(value)
            .attribute
    }
    
    static func label(_ value: String) -> KeychainAttribute {
        KeychainCatalog.Entry.label(value)
            .attribute
    }
    
    static func isInvisible(_ value: Bool) -> KeychainAttribute {
        KeychainCatalog.Entry.isInvisible(value)
            .attribute
    }
    
    static func isNegative(_ value: Bool) -> KeychainAttribute {
        KeychainCatalog.Entry.isNegative(value)
            .attribute
    }
    
    static func synchoronizable(_ value: Bool?) -> KeychainAttribute {
        KeychainCatalog.Entry.synchronizable(value)
            .attribute
    }
}
