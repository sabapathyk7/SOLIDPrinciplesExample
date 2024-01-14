//
//  AutoScroller.swift
//  SOLIDPrinciplesExample
//
//  Created by kanagasabapathy on 13/01/24.
//

import SwiftUI

struct AutoScroller: View {
    @State private var selectedImageIndex: Int = 0
    var images: [String]
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            TabView(selection: $selectedImageIndex,
                    content: {
                ForEach(0..<images.count, id: \.self) { index in
                    ZStack(alignment: .topLeading, content: {
                        AsyncImage(url: URL(string: images[index])) { image in
                            image.resizable()
                                .frame(width: 300, height: 300)
                                .aspectRatio(0.5, contentMode: .fit)
                                .clipShape(Rectangle())
                        } placeholder: {
                            ProgressView()
                        }
                    })
                    .shadow(radius: 20)
                }
            })
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            HStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Capsule()
                        .fill(Color.black.opacity(selectedImageIndex == index ? 1 :     0.33))
                        .frame(width: 35, height: 8)
                }
                .offset(y: 200)
            }
        }
    }
}

#Preview {
    AutoScroller(images: dummyProductImages)
}
