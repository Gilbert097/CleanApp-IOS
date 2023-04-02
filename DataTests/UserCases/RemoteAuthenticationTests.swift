//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Gilberto Silva on 02/04/23.
//

import XCTest
import Data
import Domain

class RemoteAuthenticationTests: XCTestCase {
    
    func test_auth_should_call_httpClient_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth(authenticationModel: makeAuthenticationModel())
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_auth_should_call_httpClient_with_correct_data() throws {
        let (sut, httpClientSpy)  = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.auth(authenticationModel: authenticationModel)
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }
}

extension RemoteAuthenticationTests {
    
    func makeSut(
        url: URL = URL(string: "http://any-url.com")!,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
}
