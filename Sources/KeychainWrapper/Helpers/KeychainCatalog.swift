//
//  KeychainCatalog.swift
//  
//
//  Created by Danny Gilbert on 7/26/22.
//

import Foundation

public struct KeychainCatalog {

    public enum Global {
        case kind(Kind)
        case account(String)
        case password(Data)
    }

    public enum Internet {
        case server(String)
        case securityDomain(String)
        case port(Int)
        case authentication(AuthenticationType)
        case path(String)
        case `protocol`(InternetProtocol)
    }

    public enum Application {
        case service(String)
        case accessControl(String)  // This attribute is mutually exclusive with the kSecAttrAccess attribute.
        case generic(Data)
    }

    public enum Entry {
        /// Read-only
        case creationDate
        case modificationDate

        case description(String)
        case comment(String)
        case creator(String)
        case type(String)
        case label(String)
        case isInvisible(Bool)
        case isNegative(Bool)
        case synchronizable(Bool?)  // Uses kSecAttrSynchronizableAny to query for all - i.e. nil
    }
}

// MARK: - Kind
extension KeychainCatalog {
    
    public enum Kind: String {
        case internet
        case application
        case certificate
        case key
        
        public var rawValue: String {
            switch self {
            case .internet: return kSecClassInternetPassword.string
            case .application: return kSecClassGenericPassword.string
            case .certificate: return kSecClassCertificate.string
            case .key: return kSecClassKey.string
            }
        }
    }
}

// MARK: - Global - Keychain Attribute
extension KeychainCatalog.Global {
    
    public var attribute: KeychainAttribute {
        KeychainAttribute(key: key, value: value)
    }

    public var key: String {
        switch self {
        case .kind: return kSecClass.string
        case .account: return kSecAttrAccount.string
        case .password: return kSecValueData.string
        }
    }

    public var value: Any {
        switch self {
        case .kind(let kind):
            return kind.rawValue

        case .account(let string):
            return string

        case .password(let data):
            return data
        }
    }
}

// MARK: - Internet - Keychain Attribute
extension KeychainCatalog.Internet {
    
    public var attribute: KeychainAttribute {
        KeychainAttribute(key: key, value: value)
    }

    public var key: String {
        switch self {
        case .server:           return kSecAttrServer.string
        case .securityDomain:   return kSecAttrSecurityDomain.string
        case .port:             return kSecAttrPort.string
        case .authentication:   return kSecAttrAuthenticationType.string
        case .path:             return kSecAttrPath.string
        case .protocol:         return kSecAttrProtocol.string
        }
    }

    public var value: Any {
        switch self {
        case .server(let string),
            .securityDomain(let string),
            .path(let string):
            return string

        case .port(let int):
            return int

        case .authentication(let authenticationType):
            return authenticationType
            
        case .protocol(let `protocol`):
            return `protocol`.rawValue
        }
    }
}

// MARK: - Internet - Authentication Types
extension KeychainCatalog.Internet {

    public enum AuthenticationType: String {
        case ntlm
        case msn
        case dpa
        case rpa
        case httpBasic
        case httpDigest
        case htmlForm
        case `default`

        public var rawValue: String {
            switch self {
            case .ntlm:         return kSecAttrAuthenticationTypeNTLM.string
            case .msn:          return kSecAttrAuthenticationTypeMSN.string
            case .dpa:          return kSecAttrAuthenticationTypeDPA.string
            case .rpa:          return kSecAttrAuthenticationTypeRPA.string
            case .httpBasic:    return kSecAttrAuthenticationTypeHTTPBasic.string
            case .httpDigest:   return kSecAttrAuthenticationTypeHTTPDigest.string
            case .htmlForm:     return kSecAttrAuthenticationTypeHTMLForm.string

            default:            return kSecAttrAuthenticationTypeDefault.string
            }
        }
    }
}

// MARK: - Application - Keychain Attribute
extension KeychainCatalog.Application {
    
    public var attribute: KeychainAttribute {
        KeychainAttribute(key: key, value: value)
    }

    public var key: String {
        switch self {
        case .service:          return kSecAttrService.string
        case .accessControl:    return kSecAttrAccessControl.string
        case .generic:          return kSecAttrGeneric.string
        }
    }

    public var value: Any {
        switch self {
        case .service(let string),
            .accessControl(let string):
            return string

        case .generic(let data):
            return data
        }
    }
}

// MARK: - Entry - Keychain Attribute
extension KeychainCatalog.Entry {
    
    public var attribute: KeychainAttribute {
        KeychainAttribute(key: key, value: value)
    }

    public var key: String {
        switch self {
        case .creationDate:         return kSecAttrCreationDate.string
        case .modificationDate:     return kSecAttrModificationDate.string
        case .description:          return kSecAttrDescription.string
        case .comment:              return kSecAttrComment.string
        case .creator:              return kSecAttrCreator.string
        case .type:                 return kSecAttrType.string
        case .label:                return kSecAttrLabel.string
        case .isInvisible:          return kSecAttrIsInvisible.string
        case .isNegative:           return kSecAttrIsNegative.string
        case .synchronizable:       return kSecAttrSynchronizable.string
        }
    }

    public var value: Any {
        switch self {

        case .creationDate,
            .modificationDate:
            return ""

        case .description(let string),
            .comment(let string),
            .creator(let string),
            .type(let string),
            .label(let string):
            return string

        case .isInvisible(let bool),
            .isNegative(let bool):
            return bool ? kCFBooleanTrue! : kCFBooleanFalse!

        case .synchronizable(let optBool):
            switch optBool {
            case .none:
                return kSecAttrSynchronizableAny
            case .some(let bool):
                return bool ? kCFBooleanTrue! : kCFBooleanFalse!
            }
        }
    }
}
