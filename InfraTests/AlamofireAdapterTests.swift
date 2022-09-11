//
//  InfraTests.swift
//  InfraTests
//
//  Created by Gilberto Silva on 15/06/22.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = Session.default){
        self.session = session
    }
    
    func post(to url: URL, with data: Data?) {
        var json: [String: Any]? = nil
        if let data = data {
            json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        }
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {
    func test_post_should_make_request_with_valid_url_and_method() throws {
        let url = makeUrl()
        let sut = makeSut()
        sut.post(to: url, with: makeValidData())
        
        let exp = expectation(description: "requestObserver")
        UrlProtocolStub.requestObserver { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_post_should_make_request_with_no_data() throws {
        let url = makeUrl()
        let sut = makeSut()
        sut.post(to: url, with: nil)
        
        let exp = expectation(description: "requestObserver")
        UrlProtocolStub.requestObserver { request in
            XCTAssertNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension AlamofireAdapterTests {
    
    private func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        return AlamofireAdapter(session: session)
    }
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    
    static func requestObserver(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    open override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    open override func startLoading() {
        UrlProtocolStub.emit?(request)
    }

    open override func stopLoading() { }
}
