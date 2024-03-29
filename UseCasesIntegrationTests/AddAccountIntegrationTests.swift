//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Gilberto Silva on 11/09/22.
//

import XCTest
import Infra
import Data
import Domain

class AddAccountIntegrationTests: XCTestCase {
    
    func test_add_account() throws {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "http://localhost:5050/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Gilberto Silva", email: "\(UUID().uuidString)@gmail.com", password: "secret", passwordConfirmation: "secret")
        
        let exp = expectation(description: "Waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            case .failure:
                XCTFail("Expect succes got \(result) instead.")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        let exp2 = expectation(description: "Waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure(let error) where error == .emailInUse:
                XCTAssertNotNil(error)
            default:
                XCTFail("Expect failure got \(result) instead.")
            }
            exp2.fulfill()
        }
        wait(for: [exp2], timeout: 5)
    }
}
