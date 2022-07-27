# KeychainWrapper

A library of wrappers / utilities for interacting with the Keychain.

## Property Wrappers

### SecureCredentials

Wrapper for generic password item in the keychain.

```swift
@SecureCredentials(
    label: "GitHub Token",              // Optional
    service: "github.token",            // Required
    account: "user@github.com"          // Optional
)
var gitHubPassword: String?
```

### InternetCredentials

Wrapper for Internet password items in the keychain.

```swift
@InternetCredentials(
    label: "GitHub Token",                          // Optional
    server: URL(string: "https://www.github.com",   // Required
    account: "user@github.com"                      // Optional
)
var gitHubPassword: String?
```

### SecureItem

Wrapper for codable items in the keychain.

```swift
@SecureItem(
    name: "Keychain Item Name"
)
var item: Codable?
```

** Advanced Tips **
To update `account` for wrappers, use the `projectedValue` like so:

```swift
$gitHub.account = "newAccount" // Updates the account field for the keychain item.
```

## Keychain

Perform *CRUD* operation with the keychain via *KeychainQuery*'s.

### KeychainQueryable

```swift
public protocol KeychainQueryable {
    var attributes: KeychainAttributes { get }
    var options: KeychainOptions { get }
}
```

By conforming to this protocol, you can get all CRUD options for free.

```swift
// MARK: - CRUD Keychain Actions
public extension KeychainQueryable {
    
    var item: KeychainItem {
        get throws {
            try Keychain.search(for: attributes, with: options)
        }
    }
    
    func update(_ attributes: KeychainAttribute...) throws {
        let uniqueAttributes = KeychainAttributes(attributes)
        try Keychain.modify(uniqueAttributes, for: self)
    }
    
    func delete() throws {
        try Keychain.remove(self)
    }
}
```

* Attributes are the necessary lookup attributes for the object.
* Options are the set of search options necesary for lookup.

#### Pre-defined KeychainOptions

```swift
    static var matchFirst: Set<KeychainOption> {
        [
            .returnData(true),
            .returnAttributes(true),
            .matchLimit(.first)
        ]
    }
    
    static var matchAll: Set<KeychainOption> {
        [
            .returnData(true),
            .returnAttributes(true),
            .matchLimit(.all)
        ]
    }
```

### Create / Update

Create items in the keychain.

*NOTE: Update function creates the item if it doesn't exist.*

```swift
let query: KeychainQuery = [
    kSecClass.string: kSecClassGenericPassword,
    kSecAttrLabel.string: "Example Label for Keychain Item",
    kSecAttrService.string: "Name of Service"
]

let attributes: KeychainAttributes = [
    kSecAttrAccount.string: "Username",
    kSecValueData.string: Data("Password".utf8)
]

try Keychain.update(attributes, using: query)
```

### Read

Read items in the keychain.

```swift
let query: KeychainQuery = [
    kSecClass.string: kSecClassGenericPassword,
    kSecAttrLabel.string: "Example Label for Keychain Item",
    kSecAttrService.string: "Name of Service"
]

let searchOptions: KeychainOptions = [
    kSecReturnAttributes.string: true,
    kSecReturnData.string: true,
    kSecMatchLimit.string: kSecMatchLimitOne
]

let item = try Keychain.read(query, options: search)        // Returns a KeychainItem (i.e. [String: Any])
let account = item[kSecAttrAccount.string] as! String       // You'll be converting  
let passwordData = item[kSecValueData.string] as! Data
```

### Delete

Delete items in the keychain.

```swift
let query: KeychainQuery = [
    kSecClass.string: kSecClassGenericPassword,
    kSecAttrLabel.string: "Example Label for Keychain Item",
    kSecAttrService.string: "Name of Service"
]

try Keychain.delete(query)
```

## Advanced Tips / Notes

Be wary of using `[kSecClass: kSecClassInternetPassword]` when reading/creating entries in the keychain for
this type cannot easily be read by apps outside of the one through which it was created. It is considered 
better practice to use `kSecClassGenericPassword` when creating entries which are intended to be shared between
tools / apps as access can be granted by the user for these entries so long as they are not associated with 
the iCloud Keychain.

Recommend adding any undefined Keychain attributes in the `KeychainAttribute` namespace to make utilizing the
`Keychain` functions easier.

## Links

* [Keychain Services](https://developer.apple.com/documentation/security/keychain_services)
