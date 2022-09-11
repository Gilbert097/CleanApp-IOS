//
//  InfraTests.swift
//  InfraTests
//
//  Created by Gilberto Silva on 15/06/22.
//

import XCTest
import Alamofire
import Data

class AlamofireAdapter: HttpPostClient {
    private let session: Session
    
    init(session: Session = Session.default){
        self.session = session
    }
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            case .failure:
                completion(.failure(.noConnectivity))
            }
        }
    }
}

class AlamofireAdapterTests: XCTestCase {
    func test_post_should_make_request_with_valid_url_and_method() throws {
        let url = makeUrl()
        testRequestFor(url: url, data: makeValidData()) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_make_request_with_no_data() throws {
        testRequestFor(data: nil) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error() {
        expectResult(.failure(.noConnectivity), when: .init(data: nil, response: nil, error: makeError()))
    }
    
    func test_post_should_complete_with_error_on_all_invalid_cases() {
        expectResult(.failure(.noConnectivity), when: .init(data: makeValidData(), response: makeResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: .init(data: makeValidData(), response: nil, error: makeError()))
        expectResult(.failure(.noConnectivity), when: .init(data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.noConnectivity), when: .init(data: nil, response: makeResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: .init(data: nil, response: makeResponse(), error: nil))
        expectResult(.failure(.noConnectivity), when: .init(data: nil, response: nil, error: nil))
    }
    
    func test_post_should_complete_with_data_when_request_completes_with_200() {
        expectResult(.success(makeValidData()), when: .init(data: makeValidData(), response: makeResponse(), error: nil))
    }
    
    func test_post_should_complete_with_no_data_when_request_completes_with_204() {
        expectResult(.success(nil), when: .init(data: nil, response: makeResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: .init(data: makeEmptyData(), response: makeResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: .init(data: makeValidData(), response: makeResponse(statusCode: 204), error: nil))
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_non_200() {
        expectResult(.failure(.badRequest), when: .init(data: makeValidData(), response: makeResponse(statusCode: 400), error: nil))
        expectResult(.failure(.badRequest), when: .init(data: makeValidData(), response: makeResponse(statusCode: 450), error: nil))
        expectResult(.failure(.badRequest), when: .init(data: makeValidData(), response: makeResponse(statusCode: 499), error: nil))
        expectResult(.failure(.serverError), when: .init(data: makeValidData(), response: makeResponse(statusCode: 500), error: nil))
        expectResult(.failure(.serverError), when: .init(data: makeValidData(), response: makeResponse(statusCode: 550), error: nil))
        expectResult(.failure(.serverError), when: .init(data: makeValidData(), response: makeResponse(statusCode: 599), error: nil))
        expectResult(.failure(.unauthorized), when: .init(data: makeValidData(), response: makeResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: .init(data: makeValidData(), response: makeResponse(statusCode: 403), error: nil))
    }
}

extension AlamofireAdapterTests {
    
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    private func testRequestFor(url: URL = makeUrl(), data: Data?, action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "requestObserver")
        sut.post(to: url, with: data) { _ in exp.fulfill() }
        
        var request: URLRequest? = nil
        UrlProtocolStub.requestObserver { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpError>, when stub: Stub, file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeValidData()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) got \(receivedResult) instead.", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

struct Stub {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func requestObserver(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    
    open override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    open override func startLoading() {
        UrlProtocolStub.emit?(request)
        
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    open override func stopLoading() { }
}
