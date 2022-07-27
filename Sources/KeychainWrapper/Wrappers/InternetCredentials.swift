//
//  InternetCredentials.swift
//  
//
//  Created by Danny Gilbert on 7/26/22.
//

import Foundation

@propertyWrapper
public class InternetCredentials {
    
    public let options: Set<KeychainOption>
    
    public let label: String
    public let server: String
    public let `protocol`: InternetProtocol
    
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
    
    public var projectedValue: InternetCredentials {
        return self
    }
    
    public init(
        options: Set<KeychainOption> = .matchFirst,
        label: String? = nil,
        server: String,
        account: String? = nil,
        `protocol`: InternetProtocol = .https
    ) {
        self.options = options
        
        self.label = label ?? server
        self.server = server
        self.protocol = `protocol`
        self._account = account
    }
}

// MARK: - Keychain Queryable
extension InternetCredentials: KeychainQueryable {
    
    public var attributes: Set<KeychainAttribute> {
        var attributes: Set<KeychainAttribute> = [
            .kind(.internet),
            .label(label),
            .server(server),
            .protocol(`protocol`)
        ]
        
        if let username = _account {
            attributes.insert(.account(username))
        }
        
        return attributes
    }
}
