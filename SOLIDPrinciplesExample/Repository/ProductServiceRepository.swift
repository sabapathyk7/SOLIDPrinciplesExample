//
//  ProductServiceRepository.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import Foundation

protocol ProductServiceRepository: ProductFetching, ProductAdding, ProductUpdating, ProductDeleting {

}

protocol ProductAdding {
    func addProduct() async throws -> Product
}
protocol ProductFetching {
    func fetchProducts() async throws -> Products
}

protocol ProductUpdating {
    func updateProducts(id: String, productTitle: String) async throws -> Product
}

protocol ProductDeleting {
    func deleteProducts(id: String) async throws -> Product
}
