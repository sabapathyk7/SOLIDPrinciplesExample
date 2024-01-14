//
//  ProductViewModel.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import Foundation
import NetworkKit

@MainActor
final class ProductViewModel: ObservableObject {
    @Published var products: Products = Products()
    @Published var error: NetworkError?
    var errorMessage: String {
        error?.customMessage ?? ""
    }
    private var productService: ProductServiceRepository
    init(productService: ProductServiceRepository = ProductServiceRepositoryImpl()) {
        self.productService = productService
        Task {
           await fetchProducts()
        }
    }
}

extension ProductViewModel {
    func fetchProducts() async {
        do {
            let productData = try await productService.fetchProducts()
            products = productData
        } catch {
            self.error = error as? NetworkError
        }
    }
    func addProduct() async {
        do {
            let product = try await productService.addProduct()
            print(product.title)
        } catch {
            self.error = error as? NetworkError
        }
    }
    func updateProducts(id: String, productTitle: String) async {
        do {
            let product = try await productService.updateProducts(id: id, productTitle: productTitle)
            print(product.title)
        } catch {
            self.error = error as? NetworkError
        }
    }

    func deleteProducts(id: String) async {
        do {
            let product = try await productService.deleteProducts(id: id)
            print(product.title)
        } catch {
            self.error = error as? NetworkError
        }
    }
    func handleAction(_ action: Action?, product: Product) {
        guard let action = action else { return }
        switch action {
        case .add:
            Task {
                await addProduct()
            }
        case .update:
            Task {
                await updateProducts(id: String(product.id), productTitle: product.title)
            }
        case .delete:
            Task {
                await deleteProducts(id: String(product.id))
            }
        }
    }
}
