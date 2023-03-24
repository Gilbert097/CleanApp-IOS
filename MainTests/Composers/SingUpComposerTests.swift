//
//  SingUpIntegrationTests.swift
//  MainTests
//
//  Created by Gilberto Silva on 21/03/23.
//

import XCTest
import Main
import UI

final class SingUpComposerTests: XCTestCase {
    
    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        //        DispatchQueue.global().async {
        //            addAccountSpy.completeWithError(.unexpected)
        //        }
    }
}

extension SingUpComposerTests{
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy) {
        let addAccountSpy = AddAccountSpy()
        let sut =  SignUpComposer.composeViewControllerWith(addAccount: addAccountSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        return (sut, addAccountSpy)
    }
}
