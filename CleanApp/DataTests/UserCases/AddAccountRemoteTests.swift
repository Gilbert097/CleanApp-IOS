//
//  DataTests.swift
//  DataTests
//
//  Created by Gilberto Silva on 11/06/22.
//

import XCTest
import Data
import Domain

class AddAccountRemoteTests: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data() throws {
        let (sut, httpClientSpy)  = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_fails() throws {
        let (sut, httpClientSpy)  = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_valid_data() throws {
        let (sut, httpClientSpy)  = makeSut()
        let expextedAccount = makeAccountModel()
        expect(sut, completeWith: .success(expextedAccount), when: {
            httpClientSpy.completeWithData(expextedAccount.toData()!)
        })
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() throws {
        let (sut, httpClientSpy)  = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated() throws {
        let httpClientSpy = HttpClientSpy()
        var sut: AddAccountRemote? = AddAccountRemote(url: makeUrl(), httpPostClient: httpClientSpy)
        var result: Result<AccountModel, DomainError>?
        sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension AddAccountRemoteTests {
    
    func makeSut(
        url: URL = URL(string: "http://any-url.com")!,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: AddAccountRemote, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = AddAccountRemote(url: url, httpPostClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    
    
    func expect(
        _ sut: AddAccountRemote,
        completeWith expectedResult: Result<AccountModel, DomainError>,
        when action: () -> Void,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "expAdd")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch(expectedResult, receivedResult){
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)):
                XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) receive \(receivedResult) instead.", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(
            name: "any_name",
            email:  "any_name@mail.com",
            password: "any_password",
            passwordConfirmation: "any_password"
        )
    }
}
