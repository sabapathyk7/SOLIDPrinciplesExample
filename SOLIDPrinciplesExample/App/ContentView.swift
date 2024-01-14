//
//  ContentView.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ProductViewModel = ProductViewModel()
    @State private var showErrorAlert = false

    var body: some View {
        VStack {
            ProductListView(viewModel: viewModel)
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
        .padding()
    }
}

#Preview {
    ContentView()
}
