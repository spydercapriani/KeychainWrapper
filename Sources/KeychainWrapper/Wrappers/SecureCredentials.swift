//
//  SecureCredentials.swift
//  
//
//  Created by Danny Gilbert on 7/22/22.
//

import Foundation

@propertyWrapper
public class SecureCredentials {
    
    public let options: Set<KeychainOption>
    
    public let label: String
    public let service: String
    
    private var _account: String?
    public var account: String? {
        get { _account }
        set {
            do {
                try update(.account(newValue ?? ""))
                _account = newValue
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    public var wrappedValue: String? {
        get {
            do {
                guard
                    let data = try item[kSecValueData.string] as? Data,
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
                    try delete()
                } catch {
                    fatalError(error.localizedDescription)
                }
                return
            }
            
            do {
                try update(.password(Data(newPassword.utf8)))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    public var projectedValue: SecureCredentials {
        return self
    }
    
    public init(
        options: Set<KeychainOption> = .matchFirst,
        label: String? = nil,
        service: String,
        account: String? = nil
    ) {
        self.options = options
        
        self.label = label ?? service
        self.service = service
        self._account = account
    }
}

// MARK: - Keychain Queryable
extension SecureCredentials: KeychainQueryable {
    
    public var attributes: KeychainAttributes {
        var attributes: KeychainAttributes = [
            .kind(.application),
            .label(label),
            .service(service)
        ]
        if let username = _account {
            attributes.insert(.account(username))
        }
        return attributes
    }
}
