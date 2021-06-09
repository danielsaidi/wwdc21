//
//  ContentView.swift
//  WhatsNewInSwiftUI
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Better Lists", destination: BetterListsView())
                NavigationLink("Beyond Lists", destination: BeyondListsView())
                NavigationLink("Text & Keyboard", destination: TextKeyboardView())
                NavigationLink("More Buttons", destination: MoreButtonsView())
            }.navigationTitle("What's new in SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
