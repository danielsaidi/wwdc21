//
//  BeyondListsView.swift
//  WhatsNewInSwiftUI
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI

struct BeyondListsView: View {
    
    @State private var persons = [
        Person(name: "Tim"),
        Person(name: "Craig")]
    
    let imageUrl = URL(string: "http://lorempixel.com/75/75/")!
    
    // @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    // private var personsRequest: FetchedResults<Person>
    
    var body: some View {
        List {
            table
            draggableImage
        }.navigationTitle("Beyond lists")
    }
}

private extension BeyondListsView {
    
    var draggableImage: some View {
        AsyncImage(url: imageUrl)
            .onDrag {
                NSItemProvider(object: "TestString" as NSString)
            } preview: {
                AsyncImage(url: imageUrl)
            }
            //.importsItemProviders([]) { item in }
            //.exportsItemProviders([]) { item in }
    }
    
    @ViewBuilder
    var table: some View {
#if os(macOS)
        Table(persons) {
            TableColumn("id") { Text($0.id) }
            TableColumn("name") { Text($0.name) }
        }
#endif
    }
}

private struct Person: Identifiable {
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
    
    let id: String
    let name: String
    
}

struct BeyondListsView_Previews: PreviewProvider {
    static var previews: some View {
        BeyondListsView()
    }
}
