//
//  DataTests.swift
//  DataTests
//
//  Created by Gilberto Silva on 11/06/22.
//

import XCTest

class AddAccountRemote {
    private let url: URL
    private let httpPostClient: HttpPostClient
    
    init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    func add() {
        httpPostClient.post(url: url)
    }
}

protocol HttpPostClient {
    func post(url: URL)
}

class AddAccountRemoteTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() throws {
        let url = URL(string: "http://any-url.com")
        let httpClientSpy = HttpClientSpy()
        let sut = AddAccountRemote(url: url!, httpPostClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
}

extension AddAccountRemoteTests {
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }
}
