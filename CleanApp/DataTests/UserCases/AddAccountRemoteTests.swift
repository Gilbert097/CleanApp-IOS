//
//  DataTests.swift
//  DataTests
//
//  Created by Gilberto Silva on 11/06/22.
//

import XCTest
import Domain
import Data

class AddAccountRemoteTests: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url() throws {
        let url = URL(string: "http://any-url.com")!
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
        let exp = expectation(description: "expAdd")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch(result){
            case .success: XCTFail("Expected error receive \(result) instead.")
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
                exp.fulfill()
            }
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_valid_data() throws {
          let (sut, httpClientSpy)  = makeSut()
          let exp = expectation(description: "expAdd")
          let expextedAccount = makeAccountModel()
          sut.add(addAccountModel: makeAddAccountModel()) { result in
              switch(result){
              case .success(let receivedAccount):
                  XCTAssertEqual(receivedAccount, expextedAccount)
                  exp.fulfill()
              case .failure: XCTFail("Expected error received \(result) instead.")
              }
          }
        httpClientSpy.completeWithData(expextedAccount.toData()!)
          wait(for: [exp], timeout: 1)
      }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() throws {
        let (sut, httpClientSpy)  = makeSut()
        let exp = expectation(description: "expAdd")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch(result){
            case .success: XCTFail("Expected error receive \(result) instead.")
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
                exp.fulfill()
            }
        }
        httpClientSpy.completeWithData(Data("invalid_data".utf8))
        wait(for: [exp], timeout: 1)
    }
}

extension AddAccountRemoteTests {
    
    func makeSut(
        url: URL = URL(string: "http://any-url.com")!
    ) -> (sut: AddAccountRemote, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = AddAccountRemote(url: url, httpPostClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(
            name: "any_name",
            email:  "any_name@mail.com",
            password: "any_password",
            passwordConfirmation: "any_password"
        )
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(
            id: "any_id",
            name: "any_name",
            email: "any_name@mail.com",
            password: "any_password"
        )
    }
    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError){
            completion?(.failure(error))
        }
        
        func completeWithData(_ data: Data){
            completion?(.success(data))
        }
    }
}
