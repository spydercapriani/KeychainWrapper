//
//  KeychainTests.swift
//  
//
//  Created by Danny Gilbert on 7/22/22.
//

import XCTest
@testable import KeychainWrapper

class KeychainTests: XCTestCase {
    
    let query: KeychainQuery = [
        kSecClass.string: kSecClassGenericPassword,
        kSecAttrService.string: "keychain.wrapper.test.service"
    ]
    
    let search: KeychainOptions = [
        kSecReturnAttributes.string: true,
        kSecReturnData.string: true,
        kSecMatchLimit.string: kSecMatchLimitOne
    ]

    override func setUpWithError() throws {
        try Keychain.delete(query)
    }

    override func tearDownWithError() throws {
        try Keychain.delete(query)
    }
    
    func testKeychain() throws {
        let account = "Test User"
        let password = "password"
        
        // MARK: - Writing Items
        var attributes: KeychainAttributes = [
            kSecAttrAccount.string: account,
            kSecValueData.string: Data(password.utf8)
        ]
        XCTAssertNoThrow(
            try Keychain.update(attributes, using: query),
            "Failed to write to Keychain!"
        )
        
        // MARK: - Reading Items
        XCTAssertNoThrow(
            try Keychain.read(query, options: search),
            "Failed to locate keychain item!"
        )
        let item = try Keychain.read(query, options: search)
        
        let foundPasswordData = item[kSecValueData.string] as! Data
        let foundPassword = String(data: foundPasswordData, encoding: .utf8)!
        XCTAssertEqual(
            foundPassword,
            password,
            "Passwords didn't match!"
        )
        
        let foundAccount = item[kSecAttrAccount.string] as! String
        XCTAssertEqual(
            foundAccount,
            account,
            "Accounts didn't match!"
        )
        
        // MARK: - Updating Existing Items
        let newAccount = "Dummy User"
        attributes = [
            kSecAttrAccount.string: newAccount
        ]
        XCTAssertNoThrow(
            try Keychain.update(attributes, using: query),
            "Updates failed to process!"
        )
        let updatedItem = try Keychain.read(query, options: search)
        let updatedAccount = updatedItem[kSecAttrAccount.string] as! String
        XCTAssertEqual(
            updatedAccount,
            newAccount,
            "Accounts didn't match!"
        )
    }
}
