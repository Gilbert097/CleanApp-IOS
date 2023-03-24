//
//  SingUpIntegrationTests.swift
//  MainTests
//
//  Created by Gilberto Silva on 21/03/23.
//

import XCTest
import Main

final class SingUpComposerTests: XCTestCase {
    
    func test_UI_presentation_integration() throws {
        let sut =  SignUpComposer.composeViewControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
