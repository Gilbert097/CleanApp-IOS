//
//  InfraTests.swift
//  InfraTests
//
//  Created by Gilberto Silva on 15/06/22.
//

import XCTest
import Alamofire
import Data
import Infra

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
        expectResult(.failure(.noConnectivity), when: .init(data: makeValidData(), response: makeResponse(statusCode: 300), error: nil))
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

