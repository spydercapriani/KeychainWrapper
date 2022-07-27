//
//  SecureItem.swift
//  
//
//  Created by Danny Gilbert on 7/27/22.
//

import Foundation
import Combine

@propertyWrapper
public class SecureItem<Value: Codable, ValueEncoder: TopLevelEncoder, ValueDecoder: TopLevelDecoder>
where ValueEncoder.Output == Data, ValueDecoder.Input == Data {
    
    public let options: KeychainOptions
    private let encoder: ValueEncoder
    private let decoder: ValueDecoder
    
    public let name: String
    
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
    
    public var wrappedValue: Value? {
        get {
            do {
                guard
                    let data = try item[kSecValueData.string] as? Data
                else {
                    throw KeychainError.unexpectedData(nil)
                }
                
                return try decoder.decode(Value.self, from: data)
            } catch KeychainError.itemNotFound {
                // Item not found does not constitute fatal error
                return nil
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        set {
            guard let newItem = newValue else {
                do {
                    try delete()
                } catch {
                    fatalError(error.localizedDescription)
                }
                return
            }
            
            do {
                let data = try encoder.encode(newItem)
                try update(.password(data))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    public var projectedValue: SecureItem {
        return self
    }
    
    public init(
        options: Set<KeychainOption> = .matchFirst,
        name: String,
        account: String? = nil,
        encoder: ValueEncoder,
        decoder: ValueDecoder
    ) {
        self.options = options
        self.encoder = encoder
        self.decoder = decoder
        
        self.name = name
        self._account = account
    }
}

// MARK: - Convenience Initializers
extension SecureItem where ValueEncoder == JSONEncoder, ValueDecoder == JSONDecoder {
    
    /// This initializer defaults to using a standard `JSONEncoder` / `JSONDecoder`
    /// so you can use `@SecureItem` like this:
    /// `@SecureItem(name: "com.example")`
    /// `var mySecret: Codable?`
    public convenience init(
        options: Set<KeychainOption> = .matchFirst,
        name: String,
        account: String? = nil,
        jsonEncoder: ValueEncoder = .init(),
        jsonDecoder: ValueDecoder = .init()
    ) {
        self.init(
            options: options,
            name: name,
            account: account,
            encoder: jsonEncoder,
            decoder: jsonDecoder
        )
    }
}

// MARK: - Keychain Queryable
extension SecureItem: KeychainQueryable {
    
    public var attributes: KeychainAttributes {
        var attributes: KeychainAttributes = [
            .kind(.application),
            .label(name),
            .service(name)
        ]
        if let username = _account {
            attributes.insert(.account(username))
        }
        return attributes
    }
}

extension SecureItem: Equatable where Value: Equatable {
    
    public static func == (
        lhs: SecureItem<Value, ValueEncoder, ValueDecoder>,
        rhs: SecureItem<Value, ValueEncoder, ValueDecoder>
    ) -> Bool {
        lhs.name == rhs.name &&
        lhs.account == rhs.account &&
        lhs.wrappedValue == rhs.wrappedValue
    }
}

extension SecureItem: Hashable where Value: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(account)
        hasher.combine(wrappedValue)
    }
}
