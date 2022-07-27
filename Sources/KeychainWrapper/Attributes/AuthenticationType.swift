//
//  File.swift
//  
//
//  Created by Danny Gilbert on 7/27/22.
//

import Foundation

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
