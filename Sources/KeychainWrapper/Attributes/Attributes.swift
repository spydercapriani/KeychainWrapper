//
//  Attributes.swift
//
//  Predefined Keychain Attribute Namespace
//
//  Created by Danny Gilbert on 7/26/22.
//

import Foundation

// MARK: - Global Keys
public extension KeychainAttribute {
    
    static func kind(_ value: KeychainKind) -> KeychainAttribute {
        Catalog.Global.kind(value).attribute
    }
    
    static func account(_ value: String) -> KeychainAttribute {
        Catalog.Global.account(value).attribute
    }
    
    static func password(_ value: Data) -> KeychainAttribute {
        Catalog.Global.password(value).attribute
    }
}

// MARK: - Internet Keys
public extension KeychainAttribute {
    
    static func server(_ value: String) -> KeychainAttribute {
        Catalog.Internet.server(value).attribute
    }
    
    static func securityDomain(_ value: String) -> KeychainAttribute {
        Catalog.Internet.securityDomain(value)
            .attribute
    }
    
    static func port(_ value: Int) -> KeychainAttribute {
        Catalog.Internet.port(value)
            .attribute
    }
    
    static func authentication(_ value: AuthenticationType) -> KeychainAttribute {
        Catalog.Internet.authentication(value)
            .attribute
    }
    
    static func path(_ value: String) -> KeychainAttribute {
        Catalog.Internet.path(value)
            .attribute
    }
    
    static func `protocol`(_ value: InternetProtocol) -> KeychainAttribute {
        Catalog.Internet.protocol(value)
            .attribute
    }
}

// MARK: - Application Keys
public extension KeychainAttribute {
    
    static func service(_ value: String) -> KeychainAttribute {
        Catalog.Application.service(value)
            .attribute
    }
    
    static func accessControl(_ value: String) -> KeychainAttribute {
        Catalog.Application.accessControl(value)
            .attribute
    }
    
    static func generic(_ value: Data) -> KeychainAttribute {
        Catalog.Application.generic(value)
            .attribute
    }
}

// MARK: - Entry Keys
public extension KeychainAttribute {
    
    static let creationDate: KeychainAttribute = Catalog.Entry.creationDate.attribute
    static let modificationDate: KeychainAttribute = Catalog.Entry.modificationDate.attribute
    
    static func description(_ value: String) -> KeychainAttribute {
        Catalog.Entry.description(value)
            .attribute
    }
    
    static func comment(_ value: String) -> KeychainAttribute {
        Catalog.Entry.comment(value)
            .attribute
    }
    
    static func creator(_ value: String) -> KeychainAttribute {
        Catalog.Entry.creator(value)
            .attribute
    }
    
    static func type(_ value: String) -> KeychainAttribute {
        Catalog.Entry.type(value)
            .attribute
    }
    
    static func label(_ value: String) -> KeychainAttribute {
        Catalog.Entry.label(value)
            .attribute
    }
    
    static func isInvisible(_ value: Bool) -> KeychainAttribute {
        Catalog.Entry.isInvisible(value)
            .attribute
    }
    
    static func isNegative(_ value: Bool) -> KeychainAttribute {
        Catalog.Entry.isNegative(value)
            .attribute
    }
    
    static func synchoronizable(_ value: Bool?) -> KeychainAttribute {
        Catalog.Entry.synchronizable(value)
            .attribute
    }
}
