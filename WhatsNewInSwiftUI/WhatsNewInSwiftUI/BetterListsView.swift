//
//  BetterListsView.swift
//  WhatsNewInSwiftUI
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI

struct BetterListsView: View {
    
    @State private var imageCount = 0
    
    var body: some View {
        List {
            images.listRowSeparatorTint(.red)
            editItems.listRowSeparatorTint(.green)
            swipeItem//.listRowSeparator(.hidden)
        }.refreshable {
            await loadMoreImages()
        }.task {
            await loadMoreImages()
        }//.listStyle(.inset)
        .navigationTitle("Better lists")
    }
}

private extension BetterListsView {
    
    func loadMoreImages() async {
        return await withCheckedContinuation { cont in
            print("Refreshing")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                imageCount += 1
                cont.resume()
                print("Refreshed")
            }
        }
    }
}

private extension BetterListsView {
    
    var images: some View {
        VStack {
            title("Async images")
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                ForEach(0..<imageCount, id: \.self) { _ in
                    AsyncImage(url: URL(string: "http://lorempixel.com/50/50/")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .transition(.opacity)
                    } placeholder: {
                        Color.gray
                    }.mask(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
    
    var editItems: some View {
        VStack {
            title("Array bindings")
            HStack {
                Text("Watch the session :)")
                Spacer()
            }
        }
        // Didn't want to bloat here, but you can iterate over
        // binding arrays and bind eg a textfield to each item.
        
    }
    
    var swipeItem: some View {
        Text("Swipe me left and right")
            .swipeActions(edge: .leading) {
                Button {} label: {
                    Label("Pin", systemImage: "pin")
                }.tint(.yellow)
            }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {} label: {
                    Label("Unpin", systemImage: "pin.slash")
                }
            }
    }
    
    func title(_ text: String) -> some View {
        HStack {
            Text(text)
            Spacer()
        }
        .font(.footnote)
        .padding(.bottom)
    }
}

struct BetterListsView_Previews: PreviewProvider {
    static var previews: some View {
        BetterListsView()
    }
}
