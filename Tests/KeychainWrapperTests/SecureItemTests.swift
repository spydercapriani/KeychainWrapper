//
//  SecureItemTests.swift
//  
//
//  Created by Danny Gilbert on 7/27/22.
//

import XCTest
@testable import KeychainWrapper

class SecureItemTests: XCTestCase {
    
    @SecureItem(
        name: "SecureItemTest",
        account: "Test User"
    )
    var testSubject: TestSubject?

    override func setUpWithError() throws {
        testSubject = nil
    }

    override func tearDownWithError() throws {
        testSubject = nil
    }
    
    func testPropertyWrapper() throws {
        XCTAssertNil(testSubject)
        
        let subject = TestSubject(value: "password")
        testSubject = subject
        XCTAssertEqual(
            testSubject,
            subject,
            "Objects do not match!"
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

struct TestSubject: Codable, Equatable {
    
    let value: String
}
