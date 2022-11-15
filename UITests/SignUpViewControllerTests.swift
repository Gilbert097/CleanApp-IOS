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
        let sut = SignUpViewController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicatorView.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut = SignUpViewController()
        XCTAssertNotNil(sut as LoagingView)
    }
    
    func test_sut_implements_alertView() {
        let sut = SignUpViewController()
        XCTAssertNotNil(sut as AlertView)
    }
}
