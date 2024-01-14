//
//  ProductData.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import Foundation

// MARK: - ProductData
struct ProductData: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable {
    var id: Int
    var title, description: String
    var price: Int?
    var discountPercentage: Double?
    var rating: Double
    var stock: Int
    var brand, category: String
    var thumbnail: String
    var images: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, description, price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
    init(id: Int, title: String, description: String,
         price: Int? = nil, discountPercentage: Double? = nil,
         rating: Double, stock: Int, brand: String, category: String,
         thumbnail: String, images: [String]) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let idVal = try? container.decode(String.self, forKey: .id),
           let idStr = Int(idVal) {
            self.id = idStr
        } else {
            self.id = try container.decode(Int.self, forKey: .id)
        }
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        if let priceVal = try? container.decode(String.self, forKey: .price),
           let priceString = Int(priceVal) {
            self.price = priceString
        } else {
            self.price = try container.decode(Int.self, forKey: .price)
        }
        if let discountPercentageStr = try? container.decodeIfPresent(String.self, forKey: .discountPercentage),
           let discountVal = Double(discountPercentageStr) {
            self.discountPercentage = discountVal
        } else {
            self.discountPercentage = try container.decodeIfPresent(Double.self, forKey: .discountPercentage)
        }
        if let ratingStr = try? container.decode(String.self, forKey: .rating),
           let ratingVal = Double(ratingStr) {
            self.rating = ratingVal
        } else {
            self.rating = try container.decode(Double.self, forKey: .rating)
        }
        if let stockStr = try? container.decode(String.self, forKey: .stock),
           let stockVal = Int(stockStr) {
            self.stock = stockVal
        } else {
            self.stock = try container.decode(Int.self, forKey: .stock)
        }
        self.brand = try container.decode(String.self, forKey: .brand)
        self.category = try container.decode(String.self, forKey: .category)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        if let imagesString = try? container.decode(String.self, forKey: .images) {
            self.images = imagesString.components(separatedBy: ",")
        } else if let imagesArr = try? container.decodeIfPresent([String].self, forKey: .images) {
            self.images = imagesArr
        } else {
            throw DecodingError.dataCorruptedError(forKey: .images,
                                                   in: container,
                                                   debugDescription: "Invalid images data")
        }
    }

    var priceValue: String {
        guard let price = price else { return ""}
        return "$" + String(price)
    }
    // A method to convert the Product to the required format
    func convertToRequestBody() -> StringArr? {
        let imagesString = images.joined(separator: ",") // Join the array into a single string

        return [
            "id": String(id),
            "title": title,
            "description": description,
            "price": String(price ?? Int(0.00)),
            "discountPercentage": String(discountPercentage ?? 0.0),
            "rating": String(rating),
            "stock": String(stock),
            "brand": brand,
            "category": category,
            "thumbnail": thumbnail,
            "images": imagesString
        ]
    }
}

typealias Products = [Product]

extension Product {
    static func dummyProduct() -> Product {
        return Product(id: 101,
                       title: "iPhone 15 Plus",
                       description: """
                        SIM-Free, Model A19211 6.5-inch Super Retina HD
                        display with OLED technology A12 Bionic chip with ...
                        """,
                       price: 899,
                       discountPercentage: 17.94,
                       rating: 4.44,
                       stock: 34,
                       brand: "Apple",
                       category: "smartphones",
                       thumbnail: "https://i.dummyjson.com/data/products/2/thumbnail.jpg",
                       images: [
                        "https://i.dummyjson.com/data/products/2/1.jpg",
                        "https://i.dummyjson.com/data/products/2/2.jpg",
                        "https://i.dummyjson.com/data/products/2/3.jpg",
                        "https://i.dummyjson.com/data/products/2/thumbnail.jpg"
                       ])
    }
}
extension Products {
    static func dummyProducts() -> Products {
        return [Product.dummyProduct(), Product.dummyProduct()]
    }
}

extension ProductData {
    static func dummyProductData() -> ProductData {
      return  ProductData(products: [Product.dummyProduct(), Product.dummyProduct()], total: 2, skip: 2, limit: 2)
    }
}

var dummyProductImages = [
    "https://i.dummyjson.com/data/products/2/1.jpg",
    "https://i.dummyjson.com/data/products/2/2.jpg",
    "https://i.dummyjson.com/data/products/2/3.jpg",
    "https://i.dummyjson.com/data/products/2/thumbnail.jpg"
]
