//
//  SecureCredentials.swift
//  
//
//  Created by Danny Gilbert on 7/22/22.
//

import Foundation

@propertyWrapper
public class SecureCredentials {
    
    public let label: String
    public let service: String
    
    private var _account: String?
    public var account: String? {
        get { _account }
        set {
            let attribute: KeychainAttributes = [
                kSecAttrAccount.string: newValue ?? ""
            ]

            do {
                try Keychain.update(attribute, using: query)
                _account = newValue
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    public var wrappedValue: String? {
        get {
            do {
                let item = try Keychain.read(query, options: search)
                guard
                    let data = item[kSecValueData.string] as? Data,
                    let password = String(data: data, encoding: .utf8)
                else {
                    throw KeychainError.unexpectedData(nil)
                }
                
                return password
            } catch KeychainError.itemNotFound {
                // Item not found does not constitute fatal error
                return nil
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        set {
            guard let newPassword = newValue else {
                do {
                    try Keychain.delete(query)
                } catch {
                    fatalError(error.localizedDescription)
                }
                return
            }
            let attribute: KeychainAttributes = [
                kSecValueData.string: Data(newPassword.utf8)
            ]
            
            do {
                try Keychain.update(attribute, using: query)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    public var projectedValue: SecureCredentials {
        return self
    }
    
    public init(
        label: String? = nil,
        service: String,
        account: String? = nil
    ) {
        self.label = label ?? service
        self.service = service
        self._account = account
    }
}

// MARK: - Queries
extension SecureCredentials {
    
    var query: KeychainQuery {
        var query: KeychainQuery = [
            kSecClass.string: kSecClassGenericPassword,
            kSecAttrLabel.string: label,
            kSecAttrService.string: service
        ]
        if let username = _account {
            query[kSecAttrAccount.string] = username
        }
        return query
    }
    
    var search: KeychainOptions {
        [
            kSecReturnAttributes.string: true,
            kSecReturnData.string: true,
            kSecMatchLimit.string: kSecMatchLimitOne
        ]
    }
}
