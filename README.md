# KeychainWrapper

A wrapper for interacting with the Keychain.

## Property Wrappers

### SecureCredentials

Wrapper for generic password item in the keychain. Fetches

```swift
@SecureCredentials(
    label: "GitHub Token",              // Optional
    service: "github.token",            // Required
    account: "user@github.com"          // Optional
)
var gitHubPassword: String?
```

** Advanced Tips **
To update account, use the `projectedValue` to access the wrapper value.

```swift
print($gitHubPassword.account) // accesses the account field for the keychain item.
$gitHub.account = "newAccount" // Updates the account field for the keychain item.
```

## Keychain

Perform *CRUD* operation with the keychain via *QUERIES*.

*Useful for creating future property wrappers*

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

## Links

* [Keychain Services](https://developer.apple.com/documentation/security/keychain_services)
