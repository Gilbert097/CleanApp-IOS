//
//  SingUpIntegrationTests.swift
//  MainTests
//
//  Created by Gilberto Silva on 21/03/23.
//

import XCTest
import Main

final class SingUpIntegrationTests: XCTestCase {
    
    func test_UI_presentation_integration() throws {
        debugPrint("======================")
        debugPrint(Enviroment.variable(.apiBaseUrl))
        debugPrint("======================")
        let sut =  SignUpComposer.composeViewControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
