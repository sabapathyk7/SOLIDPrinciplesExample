//
//  SOLIDPrinciplesExampleTests.swift
//  SOLIDPrinciplesExampleTests
//
//  Created by kanagasabapathy on 14/01/24.
//

import XCTest
@testable import SOLIDPrinciplesExample
import Combine
import NetworkKit

final class SOLIDPrinciplesExampleTests: XCTestCase {
    var sut: ProductViewModel!

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProductViewModel(productService: ProductServiceRepositoryImpl(networkService: MockServiceable()))
    }
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    func testFetchProductsAsync() async {
        var products = await sut.products
        await sut.fetchProducts()
        products = await sut.products
        XCTAssertGreaterThan(products.count, 0, "")
        XCTAssertEqual(products.first?.title, "iPhone 15 Plus")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            Task {
                await sut.fetchProducts()
            }
        }
    }

}

final class MockServiceable: Networkable {

    func sendRequest<T>(endpoint: NetworkKit.EndPoint,
                        resultHandler: @escaping (Result<T, NetworkKit.NetworkError>) -> Void) where T: Decodable {
        let productData = Products.dummyProducts()
        guard let product = productData as? T else {
            fatalError("Not TodoData we are expecting")
        }
        print(product)
        resultHandler(.success(product))
    }

    func sendRequest<T>(endpoint: NetworkKit.EndPoint,
                        type: T.Type) -> AnyPublisher<T, NetworkKit.NetworkError> where T: Decodable {
        let productData = Products.dummyProducts()
        guard let product = productData as? T else {
            fatalError("Not productData we are expecting")
        }
        return Just(product)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    func sendRequest<T>(endpoint: EndPoint) async throws -> T where T: Decodable {
        let productData = ProductData.dummyProductData()
        guard let product = productData as? T else {
            fatalError("Not productData we are expecting")
        }
        return product
    }
}
