//
//  KeychainKind.swift
//  
//
//  Created by Danny Gilbert on 7/27/22.
//

import Foundation

public enum KeychainKind: String {
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
