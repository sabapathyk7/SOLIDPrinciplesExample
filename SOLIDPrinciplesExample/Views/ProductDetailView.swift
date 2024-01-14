//
//  ProductDetailView.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import SwiftUI

struct ProductDetailView: View {
    @Binding var product: Product
    @Binding var action: Action?
    var body: some View {
        VStack(spacing: 10) {
            ActionButtonsView(action: $action)
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        TextField("", text: $product.title)
                            .font(.title2).bold()
                        AutoScroller(images: product.images)
                        Text(product.category.capitalized)
                            .font(.subheadline)
                            .padding()
                        Spacer()
                        Text(product.priceValue)
                            .font(.title2).bold()
                    }
                    .background(Color(red: 232/255.0, green: 241/255.0, blue: 238/255.0))
                    Spacer()
                    ProductDetailDescView(product: product)
                }
            }
            .navigationTitle(product.title).bold()
        }
    }
}

struct ActionButtonsView: View {
    @Binding var action: Action?
    var body: some View {
        HStack {
            ForEach(Action.allCases, id: \.self) { actionType in
                Spacer()
                Button {
                    self.action = actionType
                } label: {
                    Image(systemName: imageName(for: actionType))
                        .cornerRadius(10)
                }
                .frame(maxWidth: 100, alignment: .center)
            }
        }
    }
    private func imageName(for action: Action) -> String {
        switch action {
        case .add:
            return Constants.addIcon
        case .update:
            return Constants.editIcon
        case .delete:
            return Constants.deleteIcon
        }
    }
}

struct ProductDetailDescView: View {
    @State private var isViewed = false
    var product: Product

    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.description).font(.title)
                .padding(10)
            Text(product.description)
                .font(.caption)
                .padding(10)
                .multilineTextAlignment(.leading)
                .lineLimit(isViewed ? 10 : 1)
            Button(isViewed ? Constants.showLess : Constants.showMore) {
                isViewed.toggle()
            }
            .font(.subheadline).bold()
            .foregroundStyle(.black)
            .padding(10)
        }
        .background(Color(red: 239/255.0, green: 237/255.0, blue: 225/255.0))
        .padding(10)
    }
}

#Preview {
    ProductDetailView(product: .constant(Product.dummyProduct()), action: .constant(.add))
}
