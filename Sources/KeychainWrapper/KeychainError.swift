//
//  KeychainError.swift
//  
//
//  Created by Danny Gilbert on 7/15/22.
//

import Foundation

enum KeychainError: Error {
    case itemNotFound
    case unexpectedData(Error?)
    case unhandledException(status: OSStatus, msg: String)
}

// MARK: - LocalizedError
extension KeychainError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .itemNotFound:
            return "No keychain item found."
        case let .unexpectedData(error):
            return "There was a problem decoding the data from the keychain item. \(error?.localizedDescription ?? "")"
        case let .unhandledException(status, msg):
            return "Unhandled error code: \(status) - \(msg)"
        }
    }
}
