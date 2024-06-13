//
//  ProductListView.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import SwiftUI

enum Action: CaseIterable {
    case add
    case update
    case delete
}
struct ProductListView: View {
    @ObservedObject var viewModel: ProductViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var action: Action?
    @State private var showErrorAlert = false

    var body: some View {

        NavigationStack {
            Text(Constants.products).font(.title3).bold()
            Divider()
            Spacer()
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach($viewModel.products) { $product in
                        NavigationLink {
                            ProductDetailView(product: $product, action: $action)
                                .onChange(of: action) { newAction in
                                    viewModel.handleAction(newAction, product: product)
                                }
                        } label: {
                            ProductListItemView(product: product)
                        }
                    }
                })
            }
        }
        .alert(isPresented: $showErrorAlert, content: {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        })
        .onChange(of: viewModel.error) { error in
            // Trigger alert presentation when an error occurs
            showErrorAlert = error != nil
        }
    }
}
struct ProductListItemView: View {
    @State private var product: Product
    init(product: Product) {
        self.product = product
    }
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()
                    .frame(width: 180, height: 180)
                    .aspectRatio(0.5, contentMode: .fit)
                    .clipShape(Rectangle())
            } placeholder: {
                ProgressView()
            }
            Text(product.title )
                .font(.title2)
            Text(product.priceValue)
                .font(.title3).bold()
        }
        .padding()
        .foregroundStyle(.black)
    }
}

#Preview {
    ProductListView(viewModel: ProductViewModel())
}
