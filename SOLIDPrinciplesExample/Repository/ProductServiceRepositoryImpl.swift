//
//  ProductServiceRepositoryImpl.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 14/01/24.
//

import Foundation
import NetworkKit

final class ProductServiceRepositoryImpl: ProductServiceRepository {
    private var networkService: Networkable

    init(networkService: Networkable = NetworkService()) {
        self.networkService = networkService
    }

    func fetchProducts() async throws -> Products {
        let queryParams: StringArr = Constants.queryParamFetch
        let productData = try await networkService.sendRequest(endpoint:
                                      ProductEndPoint.productFetch(
                                        queryParams: queryParams)) as ProductData
        guard productData.products.isNotEmpty else {
            throw AppNetworkError.noProducts
        }
        return productData.products
    }

    func addProduct() async throws -> Product {
        let randomProduct = Product.dummyProduct()
        let requestBody = randomProduct.convertToRequestBody()
        let product = try await networkService.sendRequest(endpoint:
                                       ProductEndPoint.productAdd(
                                        body: requestBody)) as Product
        return handleSuccess(product: product)
    }

    func updateProducts(id: String, productTitle: String) async throws -> Product {
        let pathParams: StringArr = [Constants.productID: id]
        let requestBody: StringArr = [Constants.productTitle: productTitle]
        let product = try await networkService.sendRequest(endpoint:
                                      ProductEndPoint.productUpdate(
                                        pathParams: pathParams,
                                        body: requestBody)) as Product
        return handleSuccess(product: product)
    }

    func deleteProducts(id: String) async throws -> Product {
        let pathParams: StringArr = [Constants.productID: id]
        let product = try await networkService.sendRequest(endpoint:
                                         ProductEndPoint.productDelete(
                                            pathParams: pathParams)) as Product
        return handleSuccess(product: product)
    }
    private func handleSuccess(product: Product) -> Product {
        if product.title.isNotEmpty {
            print(product.title)
            return product
        }
        return Product.dummyProduct()
    }
}
