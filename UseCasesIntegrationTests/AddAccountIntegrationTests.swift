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
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let sut = AddAccountRemote(url: url, httpPostClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Gilberto Silva", email: "gilberto.silva.teste123@gmail.com", password: "secret", passwordConfirmation: "secret")
        
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
        wait(for: [exp], timeout: 10)
    }
}
