//
//  Constants.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import Foundation

extension Collection {
    var isEmpty: Bool { startIndex == endIndex }
    var isNotEmpty: Bool { !isEmpty }
}

enum Constants {
    static let products = "Products"
    static let description = "Description"
    static let showLess = "Show Less  -"
    static let showMore = "Show More  +"
    static let addIcon = "plus"
    static let editIcon = "pencil"
    static let deleteIcon = "xmark"
}
