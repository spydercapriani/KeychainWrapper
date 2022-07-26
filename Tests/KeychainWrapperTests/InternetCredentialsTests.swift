//
//  InternetCredentialsTests.swift
//  
//
//  Created by Danny Gilbert on 7/26/22.
//

import XCTest
@testable import KeychainWrapper

class InternetCredentialsTests: XCTestCase {

    @InternetCredentials(
        label: "InternetCredentialsTest",
        server: URL(string: "https://www.test.com")!,
        account: "Test User"
    )
    var testSubject: String?

    override func setUpWithError() throws {
        testSubject = nil
    }

    override func tearDownWithError() throws {
        testSubject = nil
    }
    
    func testPropertyWrapper() throws {
        XCTAssertNil(testSubject)
        
        let password = "password"
        testSubject = password
        XCTAssertEqual(
            testSubject,
            password,
            "Passwords do not match!"
        )
        
        let account = "Test User"
        XCTAssertEqual(
            $testSubject.account,
            account,
            "Accounts do not match!"
        )
        
        let newAccount = "Dummy User"
        $testSubject.account = newAccount
        XCTAssertEqual(
            $testSubject.account,
            newAccount,
            "Accounts do not match!"
        )
    }
}
