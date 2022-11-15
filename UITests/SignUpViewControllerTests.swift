//
//  UITests.swift
//  UITests
//
//  Created by Gilberto Silva on 19/09/22.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        let sut = makeSut()
        XCTAssertEqual(sut.loadingIndicatorView.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoagingView)
    }
    
    func test_sut_implements_alertView() {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_saveButton_calls_sigup_on_tap() {
        var callsCount = 0
        let sut = makeSut(signUp: { _ in
            callsCount += 1
        })
        sut.saveButton.simulateTap()
        XCTAssertEqual(callsCount, 1)
    }
}

extension SignUpViewControllerTests {
    
    private func makeSut(signUp: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController{
        let sut = SignUpViewController()
        sut.signUp = signUp
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {
    
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach{ action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
