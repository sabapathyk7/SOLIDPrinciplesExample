//
//  ProductEndPoint.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import Foundation
import NetworkKit

typealias StringArr = [String: String]

enum ProductEndPoint {
    case productFetch(queryParams: StringArr?)
    case productAdd(body: StringArr?)
    case productUpdate(pathParams: StringArr?, body: StringArr?)
    case productDelete(pathParams: StringArr?)
}

extension ProductEndPoint: EndPoint {
    var queryParams: StringArr? {
        switch self {
        case .productFetch(let queryParams):
            return queryParams
        default:
            return nil
        }
    }

    var pathParams: StringArr? {
        switch self {
        case .productUpdate(pathParams: let pathParams, body: _), .productDelete(pathParams: let pathParams):
            return pathParams
        default:
            return nil
        }
    }

    var host: String {
        "dummyjson.com"
    }

    var scheme: String {
        "https"
    }

    var path: String {
        switch self {
        case .productFetch:
            return "/products"
        case .productUpdate:
            return "/products/{id}"
        case .productDelete:
            return "/products/{id}"
        case .productAdd:
            return "/products/add"
        }
    }

    var method: NetworkKit.RequestMethod {
        switch self {
        case .productFetch:
            return .get
        case .productUpdate:
            return .put
        case .productDelete:
            return .delete
        case .productAdd:
            return .post
        }
    }

    var header: StringArr? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }

    var body: StringArr? {
        switch self {
        case .productUpdate(pathParams: _, body: let body):
            return body
        case .productAdd(body: let body):
            return body
        default:
            return nil
        }
    }
}

enum AppNetworkError: Error, Identifiable, Equatable {
    case packageError(NetworkKit.NetworkError)
    case noProducts
    var id: String {
        switch self {
        case .packageError(let networkError):
            return networkError.customMessage
        case .noProducts:
            return "NoProductsError"
        }
    }
    var customMessage: String {
        switch self {
        case .packageError(let networkError):
            return networkError.customMessage
        case .noProducts:
            return "No products available"
        }
    }
}
